import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doffy_client/models/user/user.dart';
import 'package:doffy_client/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerNumberCtrl = TextEditingController();

  TextEditingController loginNumberCrtrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShown = false;
  int? otpSend;
  int? otpEnter;

  // ignore: non_constant_identifier_names
  User? LoginUser;

  @override
  void onReady() {
    Map<String, dynamic>? users = box.read('LoginUser');
    if (users != null) {
      LoginUser = User.fromJson(users);
      //Get.to(const HomePage());
    }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpSend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar('Success', 'User added successfully',
            colorText: Colors.green);
        registerNameCtrl.clear();
        registerNumberCtrl.clear();
        otpFieldShown = false;
      } else {
        Get.snackbar('Error', 'Incorrect OTP', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  sendOtp() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill the fields', colorText: Colors.red);
        return;
      }
      int otp = 0000;
      // ignore: unnecessary_null_comparison
      if (otp != null) {
        otpFieldShown = true;
        otpSend = otp;
        Get.snackbar('Success', 'Otp send successfully ',
            colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'Otp not send', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCrtrl.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;

          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('LoginUser', userData);
          loginNumberCrtrl.clear();
          Get.to(const HomePage());
          Get.snackbar('Success', 'Login successfull ',
              colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User not found!', colorText: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'Enter Phonenumber', colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to login ', colorText: Colors.red);
    }
  }
}
