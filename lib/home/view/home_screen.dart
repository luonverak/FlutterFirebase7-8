import 'package:firebase7_8/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async => authController.logoutAuth(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {},
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
                SlidableAction(
                  borderRadius: BorderRadius.circular(10),
                  onPressed: (context) {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      color: Colors.amber,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Description",
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddEditScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
