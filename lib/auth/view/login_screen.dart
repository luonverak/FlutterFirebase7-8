import 'package:firebase7_8/auth/controller/auth_controller.dart';
import 'package:firebase7_8/auth/model/auth_model.dart';
import 'package:firebase7_8/auth/view/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/input_field.dart';
import '../widget/button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final authController = Get.put(AuthController());
  final email = TextEditingController();
  final password = TextEditingController();
  RxBool check = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            const Text(
              'Welcome to E-Shop',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 80,
            ),
            InputField(
              border: 10,
              prefixIcon: const Icon(Icons.email),
              hintText: 'Enter email',
              controller: email,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => InputField(
                border: 10,
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Enter password',
                controller: password,
                obscureText: check.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    check.value = !check.value;
                  },
                  icon: Icon((check.value == false)
                      ? Icons.visibility_off
                      : Icons.remove_red_eye),
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await authController.loginAuth(
                  AuthModel(
                    email: email.text,
                    password: password.text.trim(),
                  ),
                );
              },
              child: Button(
                color: const Color.fromARGB(255, 0, 140, 255),
                radius: 20,
                text: 'Login',
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              'Or',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 18,
            ),
            GestureDetector(
              onTap: () async => authController.signInWithGoogle(),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset('asset/icon/new.png'),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CupertinoButton(
          child: const Text(
            'Register Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Get.to(RegisterScreen()),
        ),
      ),
    );
  }
}
