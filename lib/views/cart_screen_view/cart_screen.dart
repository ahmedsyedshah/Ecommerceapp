// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/cart_screen_view/shipping_screen.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controlller = Get.put(CartCotroller());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return loadingIndicator();
          else if (snapshot.data!.docs.isEmpty)
            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          var data = snapshot.data!.docs;
          controlller.calculateTotalPrice(data);
          controlller.productSnapshot = data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Image.network(
                        "${data[index]['image']}",
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title:
                          "${data[index]['title']} (x${data[index]['quantity']})"
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                      subtitle: "${data[index]['total_price']}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .color(redColor)
                          .make(),
                      trailing: IconButton(
                        onPressed: () =>
                            FirestoreService.deleteCartDocument(data[index].id),
                        icon: const Icon(Icons.delete, color: redColor),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    Obx(
                      () => "${controlller.totalPrice.value}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make(),
                    )
                  ],
                )
                    .box
                    .padding(const EdgeInsets.all(12))
                    .color(lightGolden)
                    .width(context.screenWidth - 60)
                    .roundedSM
                    .make(),
                10.heightBox,
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        width: context.screenWidth - 60,
        height: 60,
        child: customButton(
          color: redColor,
          onPressed: () => Get.to(() => const ShippingScreen()),
          textColor: whiteColor,
          title: "Proceed to Shipping",
        ),
      ),
    );
  }
}
