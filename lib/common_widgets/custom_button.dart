import 'package:emart/consts/consts.dart';

Widget customButton({onPressed, color, textColor, required String title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPressed,
    child: title.text.color(textColor).fontFamily(bold).make(),
  );
}
