import 'package:flutter/material.dart';

class TextbuttonNavigation extends StatefulWidget {
  final String text;
  final String route;
  final TextStyle textStyle;

  const TextbuttonNavigation({
    super.key,
    required this.text,
    required this.route,
    required this.textStyle,
  });

  @override
  _TextbuttonNavigationState createState() => _TextbuttonNavigationState();
}

class _TextbuttonNavigationState extends State<TextbuttonNavigation> {
  double _opacity = 1.0; // Initial opacity for the text

  void _handlePress() {
    setState(() {
      _opacity = 0.5; // Set the opacity to 50% when the button is pressed
    });

    // Wait for a short time, then reset opacity and navigate
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0; // Reset opacity to 100% after the delay
      });

    });
    // Navigate to the specified route
    // Future.delayed(Duration(milliseconds: 1000), () {
      Navigator.pushNamed(context, widget.route);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Modify text color's opacity by adjusting the alpha channel
    Color textColorWithOpacity = widget.textStyle.color?.withOpacity(_opacity) ?? Colors.black;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _opacity = 0.5; // When the tap starts, reduce opacity
        });
      },
      onTapUp: (_) {
        setState(() {
          _opacity = 1.0; // When the tap ends, restore opacity
        });
      },
      onTapCancel: () {
        setState(() {
          _opacity = 1.0; // If the tap is canceled, restore opacity
        });
      },
      child: TextButton(
        onPressed: _handlePress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          splashFactory: NoSplash.splashFactory,
          foregroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        child: Text(
          widget.text, // Display the text passed to the button
          style: widget.textStyle.copyWith(color: textColorWithOpacity), // Use modified color
        ),
      ),
    );
  }
}
