import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zekrayaty_app/core/error_handling/failures.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/auth_screen.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';
import 'package:zekrayaty_app/screens/profile_screen.dart';

class FirebaseController extends GetxController {
  static FirebaseController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late Rx<User?> FirebaseUser = Rx<User?>(null);

  // User? get FirebaseUserr => FirebaseUser.value;

  void onReady() {
    FirebaseUser = Rx<User?>(_auth.currentUser);
    FirebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    ever(FirebaseUser, (callback) => setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => AuthScreen())
        : Get.offAll(() => HomeScreen());
  }

// ========================Email&password Auth==================================
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser.value != null
          ? Get.offAll(
              () => CreatProfileScreen(),
            )
          : Get.to(() => AuthScreen());
    } on FirebaseAuthException catch (e) {
      final ex = Failure.code(e.code);
      print('Failure Auth Exception ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = Failure();
      print('EXCEPTION ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser != null) {
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar("Error", "User not found");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "User not found");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Invalid email or password");
      } else {
        Get.snackbar("Error", "Login failed: ${e.message}");
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    }
  }

// ==============================Google Auth====================================

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// ==============================User profile===================================

  createProfile(UserModel user) async {
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(
            () => Get.snackbar("Success", "Your profile has been created"))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong");
      print(error.toString());
    });
  }

  Future<UserModel> getProfileDetails(String email) async {
    try {
      final snapshot = await _db
          .collection("Users")
          .where('email', isEqualTo: email)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromSnapshot(snapshot.docs.first);
      } else {
        throw Exception("User not found");
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "Firebase error occurred: ${e.message}");
      rethrow;
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
      rethrow;
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    try {
      final QuerySnapshot querySnapshot = await _db
          .collection('Users')
          .where('email', isEqualTo: updatedUser.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final String documentID = querySnapshot.docs.first.id;
        await _db
            .collection('Users')
            .doc(documentID)
            .update(updatedUser.toJson());
        Get.snackbar("Success", "Profile updated successfully");
        Get.offAll(() => HomeScreen());
      } else {
        Get.snackbar("Error", "User profile not found");
      }
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "Firebase error occurred: ${e.message}");
      rethrow;
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred: $e");
      rethrow;
    }
  }

// ==============================Log out========================================
  Future<void> logOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(AuthScreen());
    } catch (e) {
      throw 'Unable to logout';
    }
  }
}
