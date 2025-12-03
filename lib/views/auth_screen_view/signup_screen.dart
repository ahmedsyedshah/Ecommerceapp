import 'package:emart/common_widgets/app_logo_widget.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isCheck = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

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
              "Join $appname".text.fontFamily(bold).white.size(18).make(),
              20.heightBox,

              // MAIN CARD
              Column(
                children: [
                  customTextField(
                    title: name,
                    hint: nameHint,
                    controller: nameController,
                    isPass: false,
                  ),
                  customTextField(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isPass: false,
                  ),
                  customTextField(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true,
                  ),
                  customTextField(
                    title: retypePass,
                    hint: passwordHint,
                    controller: retypePasswordController,
                    isPass: true,
                  ),

                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        checkColor: whiteColor,
                        activeColor: redColor,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue!;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: agree,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: termsAndCondition,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                              ),
                              TextSpan(
                                text: ' & ',
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // DISABLED SIGNUP BUTTON
                  customButton(
                    color: isCheck ? redColor : lightGrey,
                    title: signup,
                    textColor: isCheck ? whiteColor : Colors.black26,
                    onPressed: () {
                      if (!isCheck) return;

                      VxToast.show(context,
                          msg: "Signup is disabled in this version");
                    },
                  ).box.width(context.screenWidth - 50).make(),

                  10.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
                  ),
                ],
              )
                  .box
                  .white
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .rounded
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
