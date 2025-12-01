import 'package:emart/consts/consts.dart';

class FirestoreService {
  // get users data
  static getUser(uid) => firestore
      .collection(usersCollection)
      .where('id', isEqualTo: uid)
      .snapshots();

  // get products according category
  static getProducts(category) => firestore
      .collection(productsCollection)
      .where('p_category', isEqualTo: category)
      .snapshots();

  // get cart
  static getCart(uid) => firestore
      .collection(cartCollection)
      .where('added_by', isEqualTo: uid)
      .snapshots();

  // delete cart document from databse
  static deleteCartDocument(docId) =>
      firestore.collection(cartCollection).doc(docId).delete();

  // gett all chat messages
  static getChatMessages(docId) => firestore
      .collection(chatsCollection)
      .doc(docId)
      .collection(messagesCollection)
      .orderBy('created_on', descending: false)
      .snapshots();

  // get all orders
  static getAllOrders() => firestore
      .collection(ordersCollection)
      .where('order_by', isEqualTo: currentUser!.uid)
      .snapshots();

  // get wishlist items
  static getWishlistItems() => firestore
      .collection(productsCollection)
      .where('p_wishlist', arrayContains: currentUser!.uid)
      .snapshots();

  // get all messages
  static getAllMessages() => firestore
      .collection(chatsCollection)
      .where('fromId', isEqualTo: currentUser!.uid)
      .snapshots();

  // get cart, wishlist, and orders count
  static getCount() async => await Future.wait([
        firestore
            .collection(cartCollection)
            .where('added_by', isEqualTo: currentUser!.uid)
            .get()
            .then(
              (value) => value.docs.length,
            ),
        firestore
            .collection(productsCollection)
            .where('p_wishlist', arrayContains: currentUser!.uid)
            .get()
            .then(
              (value) => value.docs.length,
            ),
        firestore
            .collection(cartCollection)
            .where('order_by', isEqualTo: currentUser!.uid)
            .get()
            .then(
              (value) => value.docs.length,
            ),
      ]);

  // get all products
  static getAllProducts() =>
      firestore.collection(productsCollection).snapshots();

  // get featured products
  static getFeaturedProduct() => firestore
      .collection(productsCollection)
      .where('p_is_featured', isEqualTo: true)
      .get();

  // get search products
  static getSearchProducts(title) =>
      firestore.collection(productsCollection).get();

  // get subcategory products
  static getSubcategoryProducts(title) => firestore
      .collection(productsCollection)
      .where('p_subcategory', isEqualTo: title)
      .snapshots();
}
