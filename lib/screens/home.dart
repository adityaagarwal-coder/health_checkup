import 'package:flutter/material.dart';
import 'package:health_checkup/screens/mycart.dart';
import 'package:health_checkup/utils/database.dart';
import 'package:health_checkup/utils/fetchPopularPackagesDetails.dart';
import 'package:health_checkup/utils/fetchtestDetails.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseServices databaseServices = new DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Center(
                      child: Text(
                        "Logo",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCart()),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          padding: EdgeInsets.all(10),
                          child: Center(child: Image.asset('assets/cart.png'))))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular lab Tests",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#10217D")),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "View more",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: HexColor("#10217D"),
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 7,
                        color: HexColor("#10217D"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          fetchDetails(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Text(
                  "Popular Packages",
                  style: TextStyle(
                      color: HexColor("#10217D"),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          fetchPopularPackages()
        ],
      ),
    ));
  }
}
