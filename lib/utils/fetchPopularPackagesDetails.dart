import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_checkup/utils/database.dart';
import 'package:health_checkup/utils/fetchtestDetails.dart';
import 'package:hexcolor/hexcolor.dart';

Widget fetchPopularPackages() {
  DatabaseServices databaseServices = new DatabaseServices();
  return StreamBuilder<QuerySnapshot>(
    stream:
        FirebaseFirestore.instance.collection('popular_packages').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        List<DocumentSnapshot> documents = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: documents.map((DocumentSnapshot document) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor("#DBDDE0"),
                    ),
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: HexColor("#2F80ED"),
                                borderRadius: BorderRadius.circular(100)),
                            child: Image.asset('assets/bottle.png'),
                          ),
                          SizedBox(width: 50,),
                          Image.asset('assets/safe.png')
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        document['name'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        text: TextSpan(
                            text:
                                'Includes ${document['number_of_tests']} tests\n',
                            style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w400,
                                color: HexColor('#6C87AE')),
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.circle,
                                size: 10.5,
                                color: HexColor('#6C87AE'),
                              )),
                              TextSpan(
                                text: ' Blood Sugar Fasting\n',
                                style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor('#6C87AE')),
                              ),
                              WidgetSpan(
                                  child: Icon(
                                Icons.circle,
                                size: 10.5,
                                color: HexColor('#6C87AE'),
                              )),
                              TextSpan(
                                text: ' Liver Function Test\n',
                                style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor('#6C87AE')),
                              ),
                              TextSpan(
                                text: 'View more',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor('#6C87AE')),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\u20B9 ${document['price']}/-',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#1BA9B5')),
                          ),
                          InkWell(
                            onTap: () {
                              databaseServices.addToCart({
                                "id": document['id'] ?? "",
                                "name": document['name'] ?? "",
                                "number_of_tests":
                                    document['number_of_tests'] ?? "",
                                "price": document['price'] ?? "",
                                "original_price":
                                    document['original_price'] ?? "",
                              }).then((_) {
                                showToast("Added to Cart");
                              }).catchError((error) {
                                print("Error adding to cart: $error");
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: HexColor('#10217D')),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Center(
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: HexColor('#10217D')),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }
    },
  );
}
