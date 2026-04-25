import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  // Data tim (nama, jobdesc, dan URL foto)
  final List<Map<String, String>> teamMembers = [
    {
      "name": "Alexander Nathaniel Anggiono",
      "jobdesc": "Backend Developer",
      "photo": "images/alex.jpg", // Ganti dengan URL foto asli
    },
    {
      "name": "Muhammad Naufal Musyaddad",
      "jobdesc": "Fullstack Developer",
      "photo": "images/musyaddad.jpg", // Ganti dengan URL foto asli
    },
    {
      "name": "Kevin",
      "jobdesc": "Frontend Developer",
      "photo": "images/kevin.jpg", // Ganti dengan URL foto asli
    },
    {
      "name": "Daniel Guntoro",
      "jobdesc": "Frontend Developer",
      "photo": "images/daniel.jpg", // Ganti dengan URL foto asli
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet Our Team"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "This application was developed by a team of four for the final project of the Mobile Apps Programming course.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final member = teamMembers[index];

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          member["photo"]!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        member["name"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member["jobdesc"]!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 237, 227),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Muhammad Naufal Musyaddad has now decided to continue the development of this application, bringing massive improvements and ideas to further enhance the project.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: AboutUs()));
