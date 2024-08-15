import 'package:doffy_client/controller/logincontroller.dart';
import 'package:doffy_client/pages/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        initState: (_) {},
        builder: (ctrl) {
          return Scaffold(
              body: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.loginNumberCrtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.phone_android),
                      labelText: 'Mobile Number',
                      hintText: 'Enter Mobile Number'),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: () {
                      ctrl.loginWithPhone();
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple),
                    child: const Text('Login')),
                TextButton(
                    onPressed: () {
                      Get.to(const RegisterPage());
                    },
                    child: const Text('Register new account'))
              ],
            ),
          ));
        });
  }
}
