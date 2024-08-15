import 'package:doffy/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:doffy/pages/addproductpage.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (ctrl) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('AdminPage'),
            ),
            body: ListView.builder(
                itemCount: ctrl.products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ctrl.products[index].name ?? ''),
                    subtitle:
                        Text((ctrl.products[index].price ?? 0).toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        ctrl.deleteproduct(ctrl.products[index].id ?? '');
                      },
                    ),
                  );
                }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(const AddProduct());
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
