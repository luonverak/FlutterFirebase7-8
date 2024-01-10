import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase7_8/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  CollectionReference product =
      FirebaseFirestore.instance.collection('product_data');
  Future<void> addProduct(ProductModel model) {
    return product
        .add(model.fromJSon())
        .then((value) => print(" Added"))
        .catchError((error) => print("Failed : $error"));
  }

  Future<void> deleteProduct({required String doscId}) {
    return product
        .doc(doscId)
        .delete()
        .then((value) => print(" Deleted"))
        .catchError((error) => print("Failed : $error"));
  }

  Future<void> updateProduct(
      {required String doscId, required ProductModel model}) {
    return product
        .doc(doscId)
        .update(model.fromJSon())
        .then((value) => print(" Updated"))
        .catchError((error) => print("Failed  $error"));
  }
}
