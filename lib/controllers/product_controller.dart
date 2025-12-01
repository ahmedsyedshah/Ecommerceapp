// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subCat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubCategories(title) async {
    subCat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decoded = categoryModelFromJson(data);
    var sub =
        decoded.categories.where((element) => element.name == title).toList();

    for (var category in sub[0].subcategory) {
      subCat.add(category);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) quantity.value++;
  }

  decreaseQuantity() {
    if (quantity.value > 0) quantity.value--;
  }

  calculateTotalPrice(price) => totalPrice.value = price * quantity.value;

  addToCart({
    title,
    image,
    sellerName,
    color,
    quantity,
    totalPrice,
    vendorId,
    context,
  }) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': image,
      'seller_name': sellerName,
      'color': color,
      'quantity': quantity,
      'total_price': totalPrice,
      'vendor_id': vendorId,
      'added_by': currentUser!.uid
    }).onError(
        (error, stackTrace) => VxToast.show(context, msg: error.toString()));
  }

  resetValues() {
    quantity.value = 0;
    totalPrice.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishList(docId, context) async {
    firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from Wishlist");
  }

  checkIsFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid))
      isFav(true);
    else
      isFav(false);
  }
}
