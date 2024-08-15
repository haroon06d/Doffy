import 'package:doffy_client/controller/logincontroller.dart';
import 'package:doffy_client/pages/loginpage.dart';
import 'package:doffy_client/widgets/otptxt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                    'Create your Account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: ctrl.registerNameCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: 'Your Name',
                        hintText: 'Enter Your Name'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: ctrl.registerNumberCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: 'Mobile Number',
                        hintText: 'Enter Mobile Number'),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    otpController: ctrl.otpController,
                    visible: ctrl.otpFieldShown,
                    onComplete: (otp) {
                      ctrl.otpEnter = int.tryParse(otp ?? 'zoro');
                    },
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        if (ctrl.otpFieldShown) {
                          ctrl.addUser();
                        } else {
                          ctrl.sendOtp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple),
                      child:
                          Text(ctrl.otpFieldShown ? 'Register' : 'Send OTP')),
                  TextButton(
                      onPressed: () {
                        Get.to(const LoginPage());
                      },
                      child: const Text('Login'))
                ],
              ),
            ),
          );
        });
  }
}
