import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_checkup/screens/book_appointment.dart';
import 'package:health_checkup/screens/success_screen.dart';
import 'package:health_checkup/utils/database.dart';
import 'package:health_checkup/utils/fetchCartDetails.dart';
import 'package:health_checkup/utils/fetchtestDetails.dart';
import 'package:hexcolor/hexcolor.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  int totalSum = 0;
  int totalOriginalPrice = 0;
  DatabaseServices databaseServices = new DatabaseServices();
  List<DateTime?> finalDate = [];
  String finalTime = '';

  Future<List<String>> getItemIds() async {
    CollectionReference users = FirebaseFirestore.instance.collection('cart');
    List<String> documentIds = [];

    try {
      QuerySnapshot querySnapshot = await users.get();

      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        String id = documentSnapshot['id'] as String;
        documentIds.add(id);
      });

      return documentIds;
    } catch (error) {
      print('Error getting documents: $error');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    calculateTotalSum();
    calculateOriginalPriceSum();
  }

  void calculateTotalSum() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('cart').get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        int price = int.parse(document['price']) ?? 0;
        totalSum += price;
      });
      setState(() {
        print('Total Sum: $totalSum');
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void calculateOriginalPriceSum() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('cart').get();

      querySnapshot.docs.forEach((DocumentSnapshot document) {
        int price = int.parse(document['original_price']) ?? 0;
        totalOriginalPrice += price;
      });
      setState(() {
        print('Total Sum: $totalOriginalPrice');
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(
                  "Order review",
                  style: TextStyle(
                      color: HexColor('#10217D'),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
            fetchCartDetails(),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookAppointment((date, time) {
                              setState(() {
                                finalDate = date;
                                finalTime = time;
                              });
                              print(finalDate[0]!.day.toString() + finalTime);
                            })),
                  );
                });
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.74, color: HexColor('#DBDDE0')),
                      borderRadius: BorderRadius.circular(5.89)),
                  child: Row(
                    children: [
                      Image.asset('assets/date.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.74, color: HexColor('#DBDDE0')),
                            borderRadius: BorderRadius.circular(5.89)),
                        child: Text(
                          finalDate.isNotEmpty
                              ? '${finalDate[0]!.day.toString()}/${finalDate[0]!.month.toString()}/${finalDate[0]!.year.toString()} ${finalTime}'
                              : 'Select Date',
                          style: TextStyle(
                              color: HexColor('#10217D'),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.74, color: HexColor('#DBDDE0')),
                    borderRadius: BorderRadius.circular(5.89)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "M.R.P Total",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#475569')),
                        ),
                        Text(
                          totalSum.toString(),
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#475569')),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#475569')),
                        ),
                        Text(
                          (totalOriginalPrice - totalSum).toString(),
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#475569')),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount to be paid",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#10217D')),
                        ),
                        Text(
                          "\u20B9 ${totalSum.toString()}/-",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#10217D')),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text("Total savings",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor('#0F172A'))),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "\u20B9 ${(totalOriginalPrice - totalSum).toString()}/-",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#10217D')),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Radio(groupValue: 1, value: 0, onChanged: (e) {}),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Hard Copy of Reports",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: HexColor('#344054')),
                    ),
                    Text(
                      "Reports will be delivered within 3-4 working days. Hard copy charges\nare non-refundable once the reports have been dispatched. ₹150\n per person",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: HexColor('#667085')),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () async {
                List<String> allCartItems = await getItemIds();
                databaseServices.createOrder({
                  "itemIds": allCartItems,
                  "totalAmount": totalSum.toString(),
                  "date": DateTime.now()
                }).then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessScreen()),
                  );
                }).catchError((error) {
                  // Handle the error if addToCart operation fails
                  print("Error placing order: $error");
                });
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor('#10217D'),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Center(
                    child: Text(
                      "Schedule",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
