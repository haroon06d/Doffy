import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doffy_client/models/productcategory/productcategory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;
  // late CollectionReference brandCollection;

  List<Product> products = [];
  List<Product> productsShowUI = [];
  List<ProductCategory> productCategories = [];
  // List<ProductBrand> productBrands = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    // brandCollection =  firestore.collection('brands');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedproducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedproducts);
      productsShowUI.assignAll(products);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }
  // fetchBrand() async {
  //   try {
  //     QuerySnapshot brandsSnapshot = await brandsCollection.get();
  //     final List<ProductBrand> retrievedBrands = brandsSnapshot.docs
  //         .map((doc) =>
  //             ProductBrand.fromJson(doc.data() as Map<String, dynamic>))
  //         .toList();
  //     productBrands.clear();
  //     productBrands.assignAll(retrievedBrands);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString(), colorText: Colors.red);
  //   } finally {
  //     update();
  //   }
  // }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      productCategories.clear();
      productCategories.assignAll(retrievedCategories);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productsShowUI.clear();
    productsShowUI =
        products.where((product) => product.category == category).toList();
    update();
  }
// filterByBrand(List<String> brands) {
//     if(brands.isEmpty){
//         productsShowUI= products;
//     }else{
//         List<String> lowerCaseBrands = brands.map((brand) = brand.toLowerCase()).toList();
//         productsShowUI = products.where((product) => lowerCaseBrands.contains(product.brand?.toLowerCase()))
//       // productsShowUI = products.where((product) => product.brand == brands.toList();
//     update();
//     }
//   }

  sortByPrice(bool ascending) {
    List<Product> sortedProducts = List<Product>.from(productsShowUI);
    sortedProducts.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    productsShowUI = sortedProducts;
    update();
  }


}
