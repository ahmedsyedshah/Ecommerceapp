// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/cart_controller.dart';
import 'package:emart/views/cart_screen_view/payment_screen.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartCotroller>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              hint: address,
              isPass: false,
              title: address,
              controller: controller.addressController,
            ),
            customTextField(
              hint: city,
              isPass: false,
              title: city,
              controller: controller.cityController,
            ),
            customTextField(
              hint: state,
              isPass: false,
              title: state,
              controller: controller.stateController,
            ),
            customTextField(
              hint: postalCode,
              isPass: false,
              title: postalCode,
              controller: controller.postalCodeController,
            ),
            customTextField(
              hint: phone,
              isPass: false,
              title: phone,
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: customButton(
          onPressed: () {
            if (controller.addressController.text.isNotEmpty &&
                controller.cityController.text.isNotEmpty &&
                controller.stateController.text.isNotEmpty &&
                controller.postalCodeController.text.isNotEmpty &&
                controller.phoneController.text.isNotEmpty)
              Get.to(() => const PaymentScreen());
            else
              VxToast.show(context, msg: "Please fill all fields");
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
    );
  }
}
