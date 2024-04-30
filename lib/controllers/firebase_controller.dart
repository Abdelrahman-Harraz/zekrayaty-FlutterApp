import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zekrayaty_app/core/error_handling/failures.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/auth_screen.dart';
import 'package:zekrayaty_app/screens/home_screen.dart';
import 'package:zekrayaty_app/screens/profile_screen.dart';

class FirebaseController extends GetxController {
  static FirebaseController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late final Rx<User?> FirebaseUser;

  void onReady() {
    FirebaseUser = Rx<User?>(_auth.currentUser);
    FirebaseUser.bindStream(_auth.userChanges());
    ever(FirebaseUser, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => AuthScreen())
        : Get.offAll(() => HomeScreen());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser.value != null
          ? Get.offAll(() => ProfileScreen())
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
      FirebaseUser.value != null
          ? Get.offAll(
              () => HomeScreen()) //TODO change it because its for testing
          : Get.to(() => AuthScreen());
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

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
    final snapshot = await _db
        .collection("Users")
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromSnapshot(snapshot.docs.first);
    } else {
      throw Exception(
          "User not found"); // Handle the case where no user is found
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
        Get.to(() => HomeScreen());
      } else {
        Get.snackbar("Error", "User profile not found");
      }
    } catch (error) {
      Get.snackbar("Error", "Failed to update profile");
      print(error.toString());
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    Get.offAll(AuthScreen());
  }
}
