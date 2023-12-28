import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/input_field.dart';
import '../widget/button.dart';
import '../widget/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
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
            InputField(
              border: 10,
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter password',
              controller: password,
              obscureText: false,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Button(
              color: const Color.fromARGB(255, 0, 140, 255),
              radius: 20,
              text: 'Login',
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
          onPressed: () {},
        ),
      ),
    );
  }
}
