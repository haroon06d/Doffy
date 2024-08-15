import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doffy_client/models/user/user.dart';
import 'package:doffy_client/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'logincontroller.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  TextEditingController addressController = TextEditingController();

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;

    // ignore: no_leading_underscores_for_local_identifiers
    Razorpay _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_CkjkBHB3TQcyK1',
      'amount': price * 100,
      'name': item,
      'description': description,
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    orderSuccess(transactionID: response.paymentId);
    Get.snackbar('Success', 'Payment successfull ', colorText: Colors.green);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Failed', 'Payment failed ', colorText: Colors.red);
  }

  Future<void> orderSuccess({required String? transactionID}) async {
    User? loginUse = Get.find<LoginController>().LoginUser;
    try {
      if (transactionID != null) {
        // ignore: unused_local_variable
        DocumentReference docRef = await orderCollection.add({
          'customer': loginUse?.name ?? '',
          'phone': loginUse?.number ?? '',
          'item': itemName,
          'price': orderPrice,
          'address': orderAddress,
          'transactionID': transactionID,
          'dateTime': DateTime.now().toString(),
        });
        showOrderDialog(docRef.id);
        Get.snackbar('Order successfull ', '', colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'Please fill all feilds', colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', 'Please fill all feilds', colorText: Colors.red);
    }
  }

  void showOrderDialog(String orderId) {
    Get.defaultDialog(
        title: "Order Success",
        content: Text("Your Order ID is $orderId"),
        confirm: ElevatedButton(
            onPressed: () {
              Get.off(const HomePage());
            },
            child: const Text("Close")));
  }
}
