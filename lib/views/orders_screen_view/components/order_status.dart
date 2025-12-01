import 'package:emart/consts/consts.dart';

Widget orderStatus({icon, color, String? title, showDone}) => ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 30,
      )
          .box
          .border(color: color)
          .roundedSM
          .padding(const EdgeInsets.all(4))
          .make(),
      trailing: SizedBox(
        height: 100,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title!.text.color(darkFontGrey).size(16).make(),
            showDone
                ? const Icon(
                    Icons.done,
                    color: redColor,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
