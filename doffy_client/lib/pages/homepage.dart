import 'package:doffy_client/controller/homecontroller.dart';
import 'package:doffy_client/pages/loginpage.dart';
import 'package:doffy_client/pages/product_descriptionpage.dart';
import 'package:doffy_client/widgets/dropdownbutton.dart';
import 'package:doffy_client/widgets/multiselect_dropdownbtn.dart';
import 'package:doffy_client/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (ctrl) {
          return RefreshIndicator(
            onRefresh: () async {
              ctrl.fetchProducts();
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'doffy',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        GetStorage box = GetStorage();
                        box.erase();
                        Get.offAll(const LoginPage());
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ctrl.productCategories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              ctrl.filterByCategory(
                                  ctrl.productCategories[index].name ?? '');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Chip(
                                  label: Text(
                                      ctrl.productCategories[index].name ??
                                          'Error')),
                            ),
                          );
                        }),
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: MultiSelDropdown(
                        items: const ['Item 1', 'Item 2', 'Item 3'],
                        onSelectionChanged: (selectedItems) {
                          // ctrl.filterByBrand(selectedItems);
                        },
                      )),
                      Flexible(
                        child: Dropdownbtn(
                            items: const ['Low to High', 'High to Low'],
                            selectedItemText: 'Sort',
                            onSelected: (selected) {
                              ctrl.sortByPrice(
                                  selected == 'Low to High' ? true : false);
                            }),
                      )
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemCount: ctrl.productsShowUI.length,
                        itemBuilder: ((context, index) {
                          return ProductCard(
                            name: ctrl.productsShowUI[index].name ?? 'No Name',
                            imageurl: ctrl.productsShowUI[index].image ?? 'url',
                            offerTag: '20% OFF',
                            onTap: () {
                              Get.to(const ProductDescriptionPage(),
                                  arguments: {
                                    'data': ctrl.productsShowUI[index]
                                  });
                            },
                          );
                        })),
                  )
                ],
              ),
            ),
          );
        });
  }
}
