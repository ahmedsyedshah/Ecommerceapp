import 'package:emart/consts/consts.dart';
import 'package:emart/views/orders_screen_view/components/order_status.dart';
import 'package:emart/views/orders_screen_view/order_placed_details.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailsScreen extends StatelessWidget {
  final dynamic data;
  const OrderDetailsScreen({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data['order_placed'],
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up_alt,
                title: "Confirmed",
                showDone: data['order_confirmed'],
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.delivery_dining_outlined,
                title: "On Delivery",
                showDone: data['order_on_delivery'],
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all,
                title: "Delivered",
                showDone: data['order_delivered'],
              ),
              const Divider(color: Colors.black54),
              10.heightBox,
              Column(
                children: [
                  orderPlacedDetails(
                    title1: "Order code",
                    details1: data['order_code'],
                    title2: "Shipping Method",
                    details2: data['shipping_method'],
                  ),
                  orderPlacedDetails(
                    title1: "Order date",
                    details1: intl.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    title2: "Payment Method",
                    details2: data['payment_method'],
                  ),
                  orderPlacedDetails(
                    title1: "Payment status",
                    details1: "Unpaid",
                    title2: "Delivery status",
                    details2: "Order placed",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            "${data['order_by_email']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            "${data['order_by_address']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            "${data['order_by_city']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            "${data['order_by_phone']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            "${data['order_by_postal_code']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              const SizedBox(height: 20),
                              "${data['total_amount']}"
                                  .text
                                  .fontFamily(bold)
                                  .color(redColor)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  data['orders'].length,
                  (index) => Column(
                    children: [
                      orderPlacedDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['total_price']
                            .toString()
                            .numCurrency,
                        details1: data['orders'][index]['quantity'].toString(),
                        details2: "Refundable",
                      ),
                      const Divider(),
                    ],
                  ),
                ).toList(),
              ).box.outerShadowMd.white.make(),
              10.heightBox,
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "SUB TOTAL"
                        .text
                        .size(16)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                    "${data['total_amount']}"
                        .numCurrency
                        .text
                        .size(16)
                        .color(redColor)
                        .make(),
                  ],
                ),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
