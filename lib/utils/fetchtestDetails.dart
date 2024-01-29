import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_checkup/utils/database.dart';
import 'package:hexcolor/hexcolor.dart';

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget fetchDetails() {
  DatabaseServices databaseServices = new DatabaseServices();
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("tests").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }
        return Container(
          child: Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 7,
                  crossAxisCount: 2,
                ),
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _documentSnapshot.data().toString().contains('name')
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                color: HexColor("#10217D"),
                                child: Center(
                                    child: Text(
                                  _documentSnapshot['name'] ?? "",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )))
                            : Container(),
                        _documentSnapshot
                                .data()
                                .toString()
                                .contains('number_of_tests')
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Includes ${_documentSnapshot['number_of_tests'] ?? ""} tests',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor("#475569")),
                                    ),
                                    Image.asset('assets/badge.png')
                                  ],
                                ),
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "Get reports in 24 hours",
                            style: TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#475569")),
                          ),
                        ),
                        Row(
                          children: [
                            _documentSnapshot
                                    .data()
                                    .toString()
                                    .contains('price')
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "\u20B9 ${_documentSnapshot['price'] ?? ""}",
                                      style: TextStyle(
                                          color: HexColor("#10217D"),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700),
                                    ))
                                : Container(),
                            _documentSnapshot
                                    .data()
                                    .toString()
                                    .contains('original_price')
                                ? Text(
                                    _documentSnapshot['original_price'] ?? "",
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 7,
                                        fontWeight: FontWeight.w400,
                                        color: HexColor("#475569")),
                                  )
                                : Container(),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            databaseServices.addToCart({
                              "id": _documentSnapshot['id'] ?? "",
                              "name": _documentSnapshot['name'] ?? "",
                              "number_of_tests":
                                  _documentSnapshot['number_of_tests'] ?? "",
                              "price": _documentSnapshot['price'] ?? "",
                              "original_price":
                                  _documentSnapshot['original_price'] ?? "",
                            }).then((_) {
                              showToast("Added to Cart");
                            }).catchError((error) {
                              // Handle the error if addToCart operation fails
                              print("Error adding to cart: $error");
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: HexColor("#10217D"),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor("#10217D"),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor("#10217D")),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        );
      });
}
