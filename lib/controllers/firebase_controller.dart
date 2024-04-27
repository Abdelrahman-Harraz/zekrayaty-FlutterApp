import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zekrayaty_app/features/Auth/data/user_model.dart';

class FirebaseController extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> createProfile(UserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).set(user.toMap());
    } catch (e) {
      print("Error creating profile: $e");
    }
  }

  Future<void> deleteProfile(String userId) async {
    try {
      await _firestore.collection('profiles').doc(userId).delete();
    } catch (e) {
      print("Error deleting profile: $e");
    }
  }

  Future<void> updateProfile(UserModel user) async {
    try {
      await _firestore.collection('profiles').doc(user.id).update(user.toMap());
    } catch (e) {
      print("Error updating profile: $e");
    }
  }
}
