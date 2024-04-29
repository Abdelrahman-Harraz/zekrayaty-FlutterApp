import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:zekrayaty_app/core/error_handling/failures.dart';
import 'package:zekrayaty_app/models/user_model.dart';
import 'package:zekrayaty_app/screens/auth_screen.dart';
import 'package:zekrayaty_app/screens/dashboard.dart';

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
          ? Get.offAll(() => HomeScreen())
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
          ? Get.offAll(() => HomeScreen())
          : Get.to(() => AuthScreen());
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logOut() async => await _auth.signOut();
}
