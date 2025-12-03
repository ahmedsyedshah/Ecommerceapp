import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // 🔥 Hardcoded Admin Credentials
  final String allowedEmail = "admin@gmail.com";
  final String allowedPassword = "123456";

  // 🔥 UPDATED LOGIN METHOD (supports admin bypass)
  Future<bool> loginMethod({email, password, context}) async {
    // 1) ADMIN BYPASS CHECK
    if (email == allowedEmail && password == allowedPassword) {
      return true; // instantly login without Firebase
    }

    // 2) NORMAL FIREBASE LOGIN
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message.toString());
      return false;
    }
  }

  // SIGNUP METHOD (unchanged)
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // STORE USER DATA (unchanged)
  storeUserdata({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': '00',
      'order_count': '00',
      'wishlist_count': '00',
    });
  }

  // SIGN OUT (unchanged)
  signoutMethod({context}) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
