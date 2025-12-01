// ignore_for_file: use_build_context_synchronously

import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/views/home_view/home.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartCotroller>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Payment".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
            children: List.generate(
              paymentMethhodsList.length,
              (index) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: controller.paymentIndex.value == index
                        ? redColor
                        : Colors.transparent,
                    width: 4,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      paymentMethodsImgList[index],
                      width: double.infinity,
                      height: 120,
                      fit: BoxFit.cover,
                      colorBlendMode: controller.paymentIndex.value == index
                          ? BlendMode.darken
                          : BlendMode.color,
                      color: controller.paymentIndex.value == index
                          ? Colors.black.withOpacity(0.2)
                          : Colors.transparent,
                    ),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              value: true,
                              activeColor: Colors.green,
                              onChanged: (value) {},
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ).onTap(() {
                controller.changePaymentIndex(index);
              }),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? loadingIndicator()
              : customButton(
                  onPressed: () async {
                    await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethhodsList[controller.paymentIndex.value],
                      totalAmount: controller.totalPrice.value,
                    );
                    await controller.clearCart();
                    VxToast.show(context, msg: orderPlaced);
                    Get.offAll(() => Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place my Order",
                ),
        ),
      ),
    );
  }
}
