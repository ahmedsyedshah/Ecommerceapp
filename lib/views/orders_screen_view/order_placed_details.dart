import 'package:emart/consts/consts.dart';

Widget orderPlacedDetails({
  String? title1,
  String? details1,
  String? title2,
  String? details2,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title1!.text.fontFamily(semibold).make(),
              details1!.text.fontFamily(semibold).color(redColor).make(),
            ],
          ),
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title2!.text.fontFamily(semibold).make(),
                details2!.text.color(fontGrey).make(),
              ],
            ),
          ),
        ],
      ),
    );
