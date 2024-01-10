import 'dart:io';
import 'dart:math';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase7_8/home/controller/product_controller.dart';
import 'package:firebase7_8/home/controller/storage_controller.dart';
import 'package:firebase7_8/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/input_field.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key, this.model, this.docId});
  late ProductModel? model;
  late String? docId;
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final storageController = Get.put(StorageController());
  final productController = Get.put(ProductController());
  late String image = '';
  reloadData() {
    name.text = model!.name;
    price.text = model!.price.toString();
    description.text = model!.description;
    image = model!.image;
  }

  RxBool check = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model == null ? 'Add product' : 'Edit product'),
        actions: [
          IconButton(
            onPressed: () async {
              await storageController
                  .uploadFile(XFile(storageController.file!.path));
              await productController.addProduct(
                ProductModel(
                  id: Random().nextInt(10000),
                  name: name.text,
                  price: double.parse(price.text),
                  description: description.text,
                  image: storageController.imageDownload.value,
                ),
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Visibility(
              visible: check.value,
              replacement: Column(
                children: [
                  Stack(
                    children: [
                      GetBuilder<StorageController>(
                        init:
                            model == null ? StorageController() : reloadData(),
                        builder: (controller) => Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red,
                            image: storageController.file == null
                                ? const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'asset/image/shopping_illustration-copy.jpg'),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(storageController.file!.path),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 15,
                        child: GestureDetector(
                          onTap: () async {
                            showAdaptiveActionSheet(
                              context: context,
                              actions: <BottomSheetAction>[
                                BottomSheetAction(
                                    title: const Text('From Gallery'),
                                    onPressed: (context) async {
                                      await storageController
                                          .openGallery()
                                          .whenComplete(() => Get.back());
                                    }),
                                BottomSheetAction(
                                    title: const Text('Open Camera'),
                                    onPressed: (context) {}),
                              ],
                              cancelAction: CancelAction(
                                title: const Text('Cancel'),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color.fromARGB(255, 191, 191, 191),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    controller: name,
                    hintText: 'Enter product name',
                    obscureText: false,
                    border: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    controller: price,
                    hintText: 'Enter product price',
                    obscureText: false,
                    border: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    controller: description,
                    hintText: 'Enter product description',
                    obscureText: false,
                    border: 5,
                    height: 150,
                  )
                ],
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );
  }
}
