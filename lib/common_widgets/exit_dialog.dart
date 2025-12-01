import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Want to exit App?".text.size(18).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          children: [
            Expanded(
              child: customButton(
                title: "Yes",
                color: redColor,
                onPressed: () => SystemNavigator.pop(),
                textColor: whiteColor,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: customButton(
                title: "No",
                color: darkFontGrey,
                onPressed: () => Navigator.of(context).pop(),
                textColor: whiteColor,
              ),
            ),
          ],
        ),
      ],
    )
        .box
        .rounded
        .color(lightGrey)
        .padding(const EdgeInsets.symmetric(horizontal: 20, vertical: 30))
        .make(),
  );
}
