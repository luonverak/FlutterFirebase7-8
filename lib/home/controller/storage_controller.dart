import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageController extends GetxController {
  XFile? file;
  late RxString imageDownload = "".obs;
  Future openGallery() async {
    try {
      final fileChoose =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      file = XFile(fileChoose!.path);
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  Future openCamera() async {
    try {
      final fileChoose =
          await ImagePicker().pickImage(source: ImageSource.camera);
      file = XFile(fileChoose!.path);
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  Future uploadFile(XFile _files) async {
    var time = DateTime.now();
    final storageRef = FirebaseStorage.instance.ref();
    final imagesRef = storageRef.child("image/$time-${_files.name}");
    try {
      await imagesRef.putFile(File(_files.path));
      imageDownload.value = await imagesRef.getDownloadURL();
      print(imageDownload);
    } catch (e) {
      print(e);
    }
  }
}
