// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/common_widgets/bg_widget.dart';
import 'package:emart/common_widgets/loading_indicator.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/services/firestore_service.dart';
import 'package:emart/views/category_screen_view/item_details.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({
    super.key,
    required this.title,
  });

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title))
      productMethod = FirestoreService.getSubcategoryProducts(title);
    else
      productMethod = FirestoreService.getProducts(title);
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(title: widget.title!.text.white.fontFamily(bold).make()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: List.generate(
                    controller.subCat.length,
                    (index) => "${controller.subCat[index]}"
                        .text
                        .color(darkFontGrey)
                        .size(12)
                        .fontFamily(semibold)
                        .makeCentered()
                        .box
                        .white
                        .padding(const EdgeInsets.symmetric(horizontal: 4))
                        .margin(const EdgeInsets.all(4))
                        .roundedSM
                        .size(120, 60)
                        .make()
                        .onTap(() {
                      switchCategory("${controller.subCat[index]}");
                      print(index);
                      setState(() {});
                    }),
                  ),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Expanded(child: loadingIndicator());
                else if (snapshot.data!.docs.isEmpty)
                  return Expanded(
                    child: "No Products found"
                        .text
                        .color(darkFontGrey)
                        .makeCentered(),
                  );

                var data = snapshot.data!.docs;

                return
                    // products
                    Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              data[index]['p_images'][0],
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            "${data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${data[index]['p_price']}"
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
                            .outerShadowSm
                            .margin(const EdgeInsets.all(4))
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          controller.checkIsFav(data[index]);
                          Get.to(() => ItemDetails(
                              title: "${data[index]['p_name']}",
                              data: data[index]));
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
