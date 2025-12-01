// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/custom_button.dart';
import 'package:emart/common_widgets/custom_text_field.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(imgProfile2, width: 80, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  : data['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 80, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(File(controller.profileImagePath.value),
                              width: 80, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
              10.heightBox,
              customButton(
                color: redColor,
                onPressed: () => controller.changeImage(),
                textColor: whiteColor,
                title: "Change",
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldPassController,
                hint: passwordHint,
                title: oldPass,
                isPass: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newPassController,
                hint: passwordHint,
                title: newPass,
                isPass: true,
              ),
              20.heightBox,
              10.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor))
                  : SizedBox(
                      width: double.maxFinite,
                      child: customButton(
                        color: redColor,
                        onPressed: () async {
                          controller.isLoading(true);

                          // if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }

                          // if old pass machtes database password
                          if (data['password'] ==
                              controller.oldPassController.text) {
                            controller.changeAuthPassword(
                              email: data['email'],
                              password: controller.oldPassController.text,
                              newPassword: controller.newPassController.text,
                              context: context,
                            );

                            await controller.updateProfile();

                            VxToast.show(context, msg: updated);
                          } else {
                            VxToast.show(context, msg: wrongOldPass);
                          }
                          controller.isLoading(false);
                          controller.oldPassController.clear();
                          controller.newPassController.clear();
                          Get.back();
                        },
                        textColor: whiteColor,
                        title: "Save",
                      ),
                    ),
            ],
          )
              .box
              .shadowSm
              .white
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 15, right: 15))
              .make(),
        ),
      ),
    );
  }
}
