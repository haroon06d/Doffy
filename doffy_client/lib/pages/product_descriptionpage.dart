import 'package:doffy_client/controller/purchasecontroller.dart';
import 'package:doffy_client/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return GetBuilder<PurchaseController>(
      init: PurchaseController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      //height: 200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  product.name ?? '',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  product.description ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Rs: ${product.price ?? ''}',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctrl.addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: 'Enter Billing Address',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.blue),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      ctrl.submitOrder(
                          price: product.price ?? 0,
                          item: product.name ?? '',
                          description: product.description ?? '');
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
