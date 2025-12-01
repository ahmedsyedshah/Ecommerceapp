import 'package:emart/consts/consts.dart';

Widget loadingIndicator() => const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(redColor),
      ),
    );
