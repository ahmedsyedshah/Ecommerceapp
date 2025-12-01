// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/chat_screen_view/chat_screen.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return loadingIndicator();
          else if (snapshot.data!.docs.isEmpty)
            return "No messages yet!".text.color(darkFontGrey).makeCentered();
          else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        child: ListTile(
                          onTap: () => Get.to(() => const ChatScreen(),
                              arguments: [
                                data[index]['friend_name'],
                                data[index]['toId']
                              ]),
                          leading: const CircleAvatar(
                            backgroundColor: redColor,
                            child: Icon(Icons.person),
                          ),
                          title: "${data[index]['friend_name']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          subtitle:
                              "${data[index]['last_message']}".text.make(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
