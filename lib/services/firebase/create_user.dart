import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to check if the username is already taken
  Future<bool> isUsernameTaken(String username) async {
    final snapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // Function to check if the email is already in use
  Future<bool> isEmailTaken(String email) async {
    final snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // Function to create a user
  Future<String?> createUser({
    required String username,
    required String email,
    required String address,
    required String password,
  }) async {
    try {
      // Check if the email or username is already taken
      if (await isEmailTaken(email)) {
        return "This email is already taken.";
      }

      if (await isUsernameTaken(username)) {
        return "This username is already taken.";
      }

      // Create user with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user!.uid;

      // Store user details in Firestore
      await _firestore.collection('users').doc(userId).set({
        'username': username,
        'email': email,
        'password': password,
        'created_at': Timestamp.now(),
      });

      // Add the first address to a subcollection called 'addresses' with a custom key
      final addressCollection = _firestore
          .collection('users')
          .doc(userId)
          .collection('addresses');

      // Get the current count of addresses
      final snapshot = await addressCollection.get();
      final addressCount = snapshot.docs.length + 1; // Increment for new address

      // Add address as "address1", "address2", etc.
      await addressCollection.doc('address$addressCount').set({
        'address': address,
        'added_at': Timestamp.now(),
      });

      return null; // User created successfully
    } catch (e) {
      return "Error creating user: ${e.toString()}";
    }
  }
}
