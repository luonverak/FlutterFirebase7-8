import 'package:firebase7_8/auth/controller/auth_controller.dart';
import 'package:firebase7_8/auth/model/auth_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/input_field.dart';
import '../widget/button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final cf_password = TextEditingController();
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Spacer(),
                const Text(
                  'Register Account',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputField(
                    border: 10,
                    prefixIcon: const Icon(Icons.email),
                    controller: email,
                    hintText: 'Enter Email',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    border: 10,
                    prefixIcon: const Icon(Icons.lock),
                    controller: password,
                    hintText: 'Enter password',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_off,
                      ),
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    border: 10,
                    prefixIcon: const Icon(Icons.lock),
                    controller: cf_password,
                    hintText: 'Enter confirm password',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.visibility_off,
                      ),
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (password.text.trim() == cf_password.text.trim()) {
                        await authController.createAuth(
                          AuthModel(
                            email: email.text,
                            password: password.text.trim(),
                          ),
                        );
                      } else {
                        Get.snackbar("Error", "Wrong password");
                      }
                    },
                    child: Button(
                      color: const Color.fromARGB(255, 0, 140, 255),
                      radius: 20,
                      text: 'Create account',
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
