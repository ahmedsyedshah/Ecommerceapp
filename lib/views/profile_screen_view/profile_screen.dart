// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/list.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/auth_screen_view/login_screen.dart';
import 'package:emart/views/messages_screen/messages_screen.dart';
import 'package:emart/views/orders_screen_view/orders_screen.dart';
import 'package:emart/views/profile_screen_view/components/cart_details.dart';
import 'package:emart/views/profile_screen_view/edit_profile_screen.dart';
import 'package:emart/views/wishlist_screen_view/wishlist_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: StreamBuilder(
      stream: FirestoreService.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return loadingIndicator();
        else if (snapshot.data!.docs.isEmpty)
          return Center(
            child: "No data".text.color(darkFontGrey).makeCentered(),
          );
        else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
            child: Column(
              children: [
                // edit profile
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.edit, color: whiteColor))
                      .onTap(() async {
                    controller.nameController.text = data['name'];

                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),

                // user details section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(imgProfile2,
                                  width: 80, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.network(data['imageUrl'],
                                  width: 80, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                      10.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            '${data['name']}'
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                            '${data['email']}'.text.white.make(),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: whiteColor),
                        ),
                        onPressed: () {
                          Get.put(AuthController())
                              .signoutMethod(context: context);
                          Get.offAll(() => LoginScreen());
                        },
                        child: logout.text.white.fontFamily(semibold).make(),
                      ),
                    ],
                  ),
                ),

                // cart
                20.heightBox,
                FutureBuilder(
                  future: FirestoreService.getCount(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return loadingIndicator();
                    var countData = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cartDetails(context.screenWidth / 3.5,
                            countData[0].toString(), "in your cart"),
                        cartDetails(context.screenWidth / 3.5,
                            countData[1].toString(), "in your wishlist"),
                        cartDetails(context.screenWidth / 3.5,
                            countData[2].toString(), "you ordered"),
                      ],
                    );
                  },
                ),

                // profile button
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Get.to(() => const OrdersScreen());
                          break;
                        case 1:
                          Get.to(() => const WishlistScreen());
                          break;
                        case 2:
                          Get.to(() => const MessagesScreen());
                          break;
                      }
                    },
                    leading:
                        Image.asset(profileButtonIconsList[index], width: 22),
                    title: profileButtonList[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  ),
                  separatorBuilder: (context, index) =>
                      const Divider(color: lightGrey),
                  itemCount: profileButtonList.length,
                )
                    .box
                    .rounded
                    .white
                    .margin(const EdgeInsets.all(12))
                    .padding(const EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ],
            ),
          );
        }
      },
    ));
  }
}
