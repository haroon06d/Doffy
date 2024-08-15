import 'package:doffy/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:doffy/widgets/dropdownbutton.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (ctrl) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('doffy'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Add New Product',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: ctrl.productNameCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: const Text('Product name'),
                            hintText: 'Enter product name'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: ctrl.productDescriptionCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: const Text('Product description'),
                            hintText: 'Enter product description'),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: ctrl.productImgCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: const Text('image url'),
                            hintText: 'Enter image url'),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: ctrl.productPriceCtrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: const Text('Product price'),
                            hintText: 'Enter product price'),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: Dropdownbtn(
                              items: const [
                                'Action Figures',
                                'Accessories',
                                'Posters',                           
                              ],
                              selectedItemText: ctrl.category,
                              onSelected: (selectedValue) {
                                ctrl.category = selectedValue ?? 'general';
                                ctrl.update();
                              },
                            ),
                          ),
                          Flexible(
                            child: Dropdownbtn(
                              items: const [
                                'One Piece',
                                'Naruto',
                                'Attack on Titan',
                                'Dragon Ball',
                                'Demon Slayer',
                                'Jujustu Kaisen',
                                
                              ],
                              selectedItemText: ctrl.brand,
                              onSelected: (selectedValue) {
                                ctrl.brand = selectedValue ?? 'un branded';
                                ctrl.update();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('offer product?'),
                      Dropdownbtn(
                        items: const ['true', 'false'],
                        selectedItemText: ctrl.offer.toString(),
                        onSelected: (selectedValue) {
                          ctrl.offer =
                              bool.tryParse(selectedValue ?? 'false') ?? false;
                          ctrl.update();
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              foregroundColor: Colors.white),
                          onPressed: () {
                            ctrl.addProduct();
                          },
                          child: const Text('Add Product'))
                    ],
                  ),
                ),
              ));
        });
  }
}
