// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/category_screen_view/item_details.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: title!.text.color(darkFontGrey).make()),
      body: FutureBuilder(
        future: FirestoreService.getSearchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return loadingIndicator();
          else if (snapshot.data!.docs.isEmpty)
            return "No such product".text.color(darkFontGrey).makeCentered();
          var data = snapshot.data!.docs;
          var filteredData = data
              .where((element) => element['p_name']
                  .toString()
                  .toLowerCase()
                  .contains(title!.toLowerCase()))
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 300,
              ),
              children: filteredData
                  .mapIndexed(
                    (currentValue, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          filteredData[index]['p_images'][0],
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const Spacer(),
                        "${filteredData[index]['p_name']}"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        "${filteredData[index]['p_price']}"
                            .numCurrency
                            .text
                            .color(redColor)
                            .fontFamily(bold)
                            .size(16)
                            .make(),
                      ],
                    )
                        .box
                        .white
                        .roundedSM
                        .shadowSm
                        .margin(const EdgeInsets.all(4))
                        .padding(const EdgeInsets.all(12))
                        .make()
                        .onTap(() {
                      Get.to(
                        () => ItemDetails(
                            title: filteredData[index]['p_name'],
                            data: filteredData[index]),
                      );
                    }),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
