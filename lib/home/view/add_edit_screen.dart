import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase7_8/home/controller/product_controller.dart';
import 'package:firebase7_8/home/controller/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/input_field.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key});
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  final storageController = Get.put(StorageController());
  final productController = Get.to(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
        actions: [
          IconButton(
            onPressed: () async {
              await storageController
                  .uploadFile(XFile(storageController.file!.path));
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  GetBuilder<StorageController>(
                    init: StorageController(),
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
        ),
      ),
    );
  }
}
