import 'dart:async';
import 'package:doffy_client/controller/homecontroller.dart';
import 'package:doffy_client/controller/logincontroller.dart';
import 'package:doffy_client/controller/purchasecontroller.dart';
import 'package:doffy_client/firebaseoptions.dart';
import 'package:doffy_client/pages/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchaseController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 142, 209, 202),
      body: SafeArea(
          child: Center(
        child: Text(
          'doffy',
          style: TextStyle(
            color: Colors.black26,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      )),
    );
  }
}
