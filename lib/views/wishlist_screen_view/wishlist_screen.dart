// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_service.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreService.getWishlistItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return loadingIndicator();
          else if (snapshot.data!.docs.isEmpty)
            return "Wishlist is Empty".text.color(darkFontGrey).makeCentered();
          else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      leading: Image.network(
                        "${data[index]['p_images'][0]}",
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      title: "${data[index]['p_name']}"
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: "${data[index]['p_price']}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .color(redColor)
                          .make(),
                      trailing: IconButton(
                        onPressed: () => firestore
                            .collection(productsCollection)
                            .doc(data[index].id)
                            .set(
                          {
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          },
                          SetOptions(merge: true),
                        ),
                        icon: const Icon(
                          Icons.favorite_outlined,
                          color: redColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
