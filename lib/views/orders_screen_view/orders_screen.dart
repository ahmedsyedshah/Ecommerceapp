// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/orders_screen_view/order_details_screen.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return loadingIndicator();
          else if (snapshot.data!.docs.isEmpty)
            return "No orders yet!".text.color(darkFontGrey).makeCentered();

          var data = snapshot.data!.docs;

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(color: Colors.black54),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              leading: "${index + 1}"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .xl3
                  .make(),
              tileColor: lightGrey,
              title: data[index]['order_code']
                  .toString()
                  .text
                  .color(redColor)
                  .fontFamily(semibold)
                  .make(),
              subtitle: data[index]['total_amount']
                  .toString()
                  .numCurrency
                  .text
                  .fontFamily(bold)
                  .make(),
              trailing: IconButton(
                onPressed: () {
                  Get.to(
                    () => OrderDetailsScreen(
                      data: data[index],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: darkFontGrey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
