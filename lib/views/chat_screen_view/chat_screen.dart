// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/chat_controller.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/chat_screen_view/components/chat_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? loadingIndicator()
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreService.getChatMessages(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return loadingIndicator();
                          else if (snapshot.data!.docs.isEmpty)
                            return Center(
                              child: "Send a message...."
                                  .text
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          return ListView(
                            children: snapshot.data!.docs.mapIndexed(
                              (currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                  alignment: data['uid'] == currentUser!.uid
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: chatBubble(data),
                                );
                              },
                            ).toList(),
                          );
                        },
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: typeMessage,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMessage(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: redColor))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 10))
                .make(),
          ],
        ),
      ),
    );
  }
}
