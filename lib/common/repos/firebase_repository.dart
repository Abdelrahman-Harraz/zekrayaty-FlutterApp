import 'dart:io';

import 'package:carousel_slider/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';

class FirebaseRepo {
  // Auth Functions
  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        rethrow;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    User? user;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        rethrow;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        rethrow;
      }
    }

    return user;
  }

  static Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Error signing in anonymously: $e');
      rethrow;
    }
  }

  static Future<void> addUserToFirestore(User fireUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(fireUser.uid)
          .set({
        'email': fireUser.email,
        'uid': fireUser.uid,
      });
      print("added user to Firestore successfuly");
    } catch (e) {
      print("addUserToFirestore thrwowwww exxxxx");
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> resetPassword({required String mail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<void> updateUserInFirestore(UserModel userModel) async {
    try {
      print("LIKES FROM updateUserInFirestore");
      // print(userModel.likes);
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toMap());
    } catch (e) {
      print("updateUserInFirestore thrwowwww exxxxx");
      print(e.toString());
      rethrow;
    }
  }

  static Future<UserModel> getUserFromFirestore(String id) async {
    try {
      // get a user document from Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      // parse the user document into a UserModel object
      UserModel user = UserModel.fromFirestore(userDoc);
      print("User From FireStore" + user.toString());
      return user;
    } catch (e) {
      print(e.toString());
      print("getUserFromFirestore throwwwww");
      rethrow;
    }
  }

  static Future<String> uploadImageToFirebase(
      File imageFile, String imageName) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('images/$imageName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      print("_uploadImageToFirebase throwwwww");
      rethrow;
    }
  }

  static Future<void> deleteImageFromFirebase(String imageUrl) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }
}
