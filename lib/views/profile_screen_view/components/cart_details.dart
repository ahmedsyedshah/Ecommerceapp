import 'package:emart/consts/consts.dart';

Widget cartDetails(width, String? count, String? title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .roundedSM
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(5))
      .make();
}
