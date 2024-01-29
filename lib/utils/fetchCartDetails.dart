import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_checkup/utils/database.dart';
import 'package:hexcolor/hexcolor.dart';

Widget fetchCartDetails() {
  DatabaseServices databaseServices = new DatabaseServices();
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("cart").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }
        return Expanded(
          child: ListView.builder(
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1)),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          color: HexColor('#10217D'),
                          child: Center(
                            child: Text(
                              "Pathology tests",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _documentSnapshot
                                          .data()
                                          .toString()
                                          .contains('name')
                                      ? Container(
                                          child: Text(
                                            _documentSnapshot['name'] ?? "",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      : Container(),
                                  _documentSnapshot
                                          .data()
                                          .toString()
                                          .contains('price')
                                      ? Container(
                                          child: Text(
                                            "\u20B9 ${_documentSnapshot['price']}/-",
                                            style: TextStyle(
                                                color: HexColor('#1BA9B5'),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              _documentSnapshot
                                      .data()
                                      .toString()
                                      .contains('original_price')
                                  ? Text(
                                      _documentSnapshot['original_price'] ?? "",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor('#5B5B5B')),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            databaseServices
                                .deleteFromCart(_documentSnapshot.id);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: HexColor('#10217D')),
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset('assets/delete.png'),
                                  Text(
                                    "Remove",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: HexColor('#10217D')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: HexColor('#10217D')),
                              borderRadius: BorderRadius.circular(50)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/upload.png'),
                                Text(
                                  "Upload prescription (optional)",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#10217D')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      });
}
