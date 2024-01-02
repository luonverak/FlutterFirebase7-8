import 'package:firebase7_8/auth/model/auth_model.dart';
import 'package:firebase7_8/home/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/login_screen.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    onCheckUser();
    super.onInit();
  }

  Future createAuth(AuthModel model) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (credential.user != null) {
        Get.snackbar('Success', 'Account create success');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', 'Something wrong.');
      }
    } catch (e) {
      print(e);
    }
    update();
  }

  Future loginAuth(AuthModel model) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      if (credential.user != null) {
        Get.offAll(HomeScreen());
        Get.snackbar('Success', 'Account login success');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', 'Something wrong.');
      }
    }
    update();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future onCheckUser() async {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offAll(LoginScreen());
        } else {
          Get.offAll(HomeScreen());
        }
      });
    });
    update();
  }

  Future logoutAuth() async {
    await FirebaseAuth.instance.signOut();
  }
}
