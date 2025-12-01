import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;

  var userName = '';

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  getUserName() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    userName = n;
  }
}
