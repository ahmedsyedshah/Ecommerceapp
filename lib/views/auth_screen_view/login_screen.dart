// ignore_for_file: must_be_immutable

import 'package:emart/common_widgets/app_logo_widget.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/auth_screen_view/signup_screen.dart';
import 'package:emart/views/home_view/home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  // controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: emailController,
                    ),
                    customTextField(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: passwordController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: forgetPass.text.make(),
                      ),
                    ),
                    5.heightBox,

                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : customButton(
                            color: redColor,
                            title: login,
                            textColor: whiteColor,
                            onPressed: () async {
                              controller.isLoading(true);

                              try {
                                controller
                                    .loginMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                )
                                    .then((success) {
                                  controller.isLoading(false);

                                  if (success) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(Home());
                                  }
                                });
                              } catch (e) {
                                controller.isLoading(false);
                                VxToast.show(context, msg: e.toString());
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),

                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,

                    customButton(
                      color: lightGolden,
                      title: signup,
                      textColor: redColor,
                      onPressed: () {
                        Get.to(() => const SignupScreen());
                      },
                    ).box.width(context.screenWidth - 50).make(),

                    10.heightBox,
                    loginWith.text.color(fontGrey).make(),
                    5.heightBox,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
                    .box
                    .white
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .rounded
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
