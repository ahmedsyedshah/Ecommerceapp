import 'package:emart/common_widgets/app_logo_widget.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/views/auth_screen_view/login_screen.dart';
import 'package:emart/views/home_view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  //TODO: password machting while signup
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => LoginScreen());
          } else {
            Get.to(() => Home());
          }
        });
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).white.size(22).make(),
            5.heightBox,
            appversion.text.white.make(),
            const Spacer(),
            credits.text.fontFamily(semibold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
