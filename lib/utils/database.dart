import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  updateTest(Map<String, dynamic> taskMap, String documentId) {
    FirebaseFirestore.instance
        .collection("tests")
        .doc(documentId)
        .set(taskMap, SetOptions(merge: true));
  }

  Future<void> createOrder(Map<String, dynamic> taskMap) async {
    try {
      await FirebaseFirestore.instance.collection("orders").add(taskMap);
    } catch (error) {
      print("Error Scheduling Order: $error");
      throw error;
    }
  }

  // dynamic addToCart(Map<String, dynamic> taskMap) {
  //   FirebaseFirestore.instance.collection("cart").add(taskMap);
  // }

  Future<void> addToCart(Map<String, dynamic> taskMap) async {
    try {
      await FirebaseFirestore.instance.collection("cart").add(taskMap);
    } catch (error) {
      print("Error adding to cart: $error");
      throw error;
    }
  }

  getTests() async {
    return await FirebaseFirestore.instance.collection("tests").snapshots();
  }

  getCartItems() async {
    return await FirebaseFirestore.instance.collection("cart").snapshots();
  }

  deleteFromCart(String documentId) {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(documentId)
        .delete()
        .catchError((e) {
      print(e.toString());
    });
  }

  deleteFields(String documentId) {
    FirebaseFirestore.instance.collection("tests").doc(documentId).update({
      'MobileNo': FieldValue.delete(),
      'Address': FieldValue.delete(),
      'Age': FieldValue.delete()
    }).catchError((e) {
      print(e.toString());
    });
  }
}
