import 'package:flutter/material.dart';
import 'package:pawtastic/widget/text_field1.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 250, 250),
        elevation: 0, // Removes shadow under the AppBar
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.pop(context); // Go back to the previous screen
        //   },
        // ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 250, 250),
      body: SafeArea(  
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              // Alignment dibawah penting agar bisa di-atas tengah-kan
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Ensures children are horizontally centered
                mainAxisSize: MainAxisSize.min, // Avoids unnecessary expansion
                children: [
                  Text(
                    "Forgot your Password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700,
                      height: 47 / 36,
                    ),
                  ),              
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      decoration: Textfield1(
                        hintText: 'Enter registered email address',
                        prefixIcon: Icons.mail_lock_rounded,
                      ).decoration,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 340,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "*",  // This part is for the '*' character
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.red, // Make the '*' red
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: " We will send you a message to set or reset your new password",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color.fromRGBO(87, 87, 87, 1.0),  // Rest of the text in the original color
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
                  
                  const SizedBox(height: 50),
                  
                  SizedBox(
                    width: 350,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(252, 147, 3, 1.0), // Set button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0), // Set border radius
                        ), 
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                          "Submit",
                          style:TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                          )
                          
                        ),
                    ),
                  ),
            
            
                ],
              ),
            ),
          ),
        
        ),
      ),
    );

  }
}
