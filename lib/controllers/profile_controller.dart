import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  // text controller
  TextEditingController nameController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  // change image
  changeImage({context}) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image == null) return;
      profileImagePath.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // upload profile image
  uploadProfileImage() async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    var file = File(profileImagePath.value);
    if (file.existsSync()) {
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImagePath.value));
      profileImageLink = await ref.getDownloadURL();
    }
  }

  // update profile

  updateProfile() async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text,
      'password': newPassController.text,
      'imageUrl': profileImageLink,
    }, SetOptions(merge: true));
    isLoading(false);
  }

  // change old password with new password
  changeAuthPassword({email, password, newPassword, context}) async {
    final credential =
        EmailAuthProvider.credential(email: email, password: password);

    await currentUser!
        .reauthenticateWithCredential(credential)
        .then((value) => currentUser!.updatePassword(newPassword))
        .onError((error, stackTrace) =>
            VxToast.show(context, msg: error.toString()));
  }
}
