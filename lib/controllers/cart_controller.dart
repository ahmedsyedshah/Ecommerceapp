import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartCotroller extends GetxController {
  var totalPrice = 0.obs;

  // text editing controller
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // payment index
  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];
  var placingOrder = false.obs;

  // calculate total price of item present in cart
  calculateTotalPrice(data) {
    totalPrice.value = 0;
    for (var price = 0; price < data.length; price++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[price]['total_price'].toString());
    }
  }

  // change payment index
  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  // order placing
  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_code': "223322",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_phone': phoneController.text,
      'order_by_postal_code': postalCodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });

    placingOrder(false);
  }

  // product details
  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'total_price': productSnapshot[i]['total_price'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  // clear cart
  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
