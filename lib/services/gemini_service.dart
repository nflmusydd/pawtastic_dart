import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class GeminiService extends StatefulWidget {
  const GeminiService({super.key});

  @override
  State<StatefulWidget> createState() => _GeminiServicesWidgetState();
}

class _GeminiServicesWidgetState extends State<GeminiService> {
  late final GenerativeModel _model;
  final TextEditingController _searchController = TextEditingController();
  final List<_ChatMessage> _messages = []; // To store chat messages
  bool _isLoading = false;

  // Function to generate text
  Future<void> _generateText(String userMessage) async {
    setState(() {
      _isLoading = true;
      _messages.add(_ChatMessage(message: userMessage, isUser: true)); // Add user's message
    });

    final prompt = 'Check the product and briefly give info about it - $userMessage';
    final content = [Content.text(prompt)];

    try {
      final response = await _model.generateContent(content);
      setState(() {
        _messages.add(_ChatMessage(message: response.text ?? "No response from bot.", isUser: false)); // Add bot's response
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(_ChatMessage(message: "Error: $e", isUser: false)); // Handle error
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final apiKey =  dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY not found in .env');
    }
    _model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      appBar: AppBar(
        title: const Text("Gemini Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Display latest messages at the bottom
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index]; // Reverse order for display
                return Align(
                  alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: message.isUser ? Color.fromRGBO(252, 147, 3, 1.0) : Color.fromRGBO(0, 220, 250, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: message.isUser ? const Radius.circular(12) : Radius.zero,
                        bottomRight: message.isUser ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Center(
              child: Lottie.asset('assets/animation/loadingblack.json', width: 200, height: 200), // Show loading animation when processing
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(152, 152, 152, 1), // Color of the hint text
                          fontSize: 16.0, // Font size
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(248,247,247, 1), // Background color of the TextField
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ), // Padding inside the TextField
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0), // Rounded border
                          borderSide: BorderSide.none, // No visible border
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16.0, // Font size of the input text
                        color: Colors.black, // Input text color
                      ),
                    ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final userMessage = _searchController.text.trim();
                    if (userMessage.isNotEmpty) {
                      _searchController.clear(); // Clear input field
                      _generateText(userMessage); // Generate bot response
                    }
                  },
                  child: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Class to represent chat messages
class _ChatMessage {
  final String message;
  final bool isUser;

  _ChatMessage({required this.message, required this.isUser});
}
