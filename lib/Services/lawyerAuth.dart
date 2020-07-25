import 'package:Lawyer/Models/lawyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import '../Models/user.dart';
import 'lawyerData.dart';

class LawyerAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Lawyer _lawyerFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? Lawyer(
            lawyerId: user.uid,
          )
        : null;
  }

  // auth change user stream
  Stream<Lawyer> get lawyer {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_lawyerFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _lawyerFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String officeAddress,
    String image,
    String nationalId,
    String since,
  ) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("result in register = " + result.toString());
      FirebaseUser user = result.user;
      print("user in register = " + user.toString());
      // create a new document for the user with the uid
      await LawyerDataService(user.uid).updateLawyerData(
        email,
        firstName,
        lastName,
        phoneNumber,
        officeAddress,
        image,
        nationalId,
        since,
      );
      return _lawyerFromFirebaseUser(user);
    } catch (error) {
      print("error while register:");
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
