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
          // Container(
          //   child: Expanded(
          //     child: GridView.builder(
          //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisSpacing: 7,
          //           crossAxisCount: 2,
          //         ),
          //         itemBuilder: (context, index) {
          //           return Container(
          //             decoration:
          //                 BoxDecoration(borderRadius: BorderRadius.circular(5)),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Container(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal: 10, vertical: 10),
          //                     color: HexColor("#10217D"),
          //                     child: Center(
          //                         child: Text(
          //                       "Thyroid Profile",
          //                       style: TextStyle(
          //                           fontSize: 10,
          //                           fontWeight: FontWeight.w700,
          //                           color: Colors.white),
          //                     ))),
          //                 Container(
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                     children: [
          //                       Text(
          //                         "Includes",
          //                         style: TextStyle(
          //                             fontSize: 11,
          //                             fontWeight: FontWeight.w400,
          //                             color: HexColor("#475569")),
          //                       ),
          //                       Image.asset('assets/badge.png')
          //                     ],
          //                   ),
          //                 ),
          //                 Container(
          //                   padding: EdgeInsets.symmetric(horizontal: 5),
          //                   child: Text(
          //                     "Get reports in hours",
          //                     style: TextStyle(
          //                         fontSize: 7,
          //                         fontWeight: FontWeight.w400,
          //                         color: HexColor("#475569")),
          //                   ),
          //                 ),
          //                 Container(
          //                     padding: EdgeInsets.symmetric(horizontal: 5),
          //                     child: Text(
          //                       "\u20B9 1000",
          //                       style: TextStyle(
          //                           color: HexColor("#10217D"),
          //                           fontSize: 10,
          //                           fontWeight: FontWeight.w700),
          //                     )),
          //                 Container(
          //                   margin: EdgeInsets.symmetric(horizontal: 5),
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 20, vertical: 10),
          //                   decoration: BoxDecoration(
          //                     color: HexColor("#10217D"),
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                   child: Center(
          //                     child: Text(
          //                       "Add to cart",
          //                       style: TextStyle(
          //                           fontSize: 8,
          //                           fontWeight: FontWeight.w700,
          //                           color: Colors.white),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.symmetric(horizontal: 5),
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 20, vertical: 5),
          //                   decoration: BoxDecoration(
          //                     border: Border.all(
          //                       color: HexColor("#10217D"),
          //                     ),
          //                     borderRadius: BorderRadius.circular(5),
          //                   ),
          //                   child: Center(
          //                     child: Text(
          //                       "View Details",
          //                       style: TextStyle(
          //                           fontSize: 8,
          //                           fontWeight: FontWeight.w700,
          //                           color: HexColor("#10217D")),
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           );
          //         }),
          //   ),
          // ),
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
          // Container(margin: EdgeInsets.symmetric(horizontal: 40),
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //         color: HexColor("#DBDDE0"),
          //       ),
          //       borderRadius: BorderRadius.circular(6)),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Container(
          //               width: 60,
          //               height: 60,
          //               decoration: BoxDecoration(
          //                   color: HexColor("#2F80ED"),
          //                   borderRadius: BorderRadius.circular(100)),
          //               child: Image.asset('assets/bottle.png'),
          //             ),
          //             Image.asset('assets/safe.png')
          //           ],
          //         ),
          //       ),
          //       Container(
          //         margin: EdgeInsets.symmetric(horizontal: 20),
          //         child: Text(
          //           "Full Body Checkup",
          //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Container(
          //         margin: EdgeInsets.symmetric(horizontal: 20),
          //         child: RichText(
          //           text: TextSpan(
          //               text: 'Includes 92 tests\n',
          //               style: TextStyle(
          //                   fontSize: 10.5,
          //                   fontWeight: FontWeight.w400,
          //                   color: HexColor('#6C87AE')),
          //               children: [
          //                 WidgetSpan(
          //                     child: Icon(
          //                   Icons.circle,
          //                   size: 10.5,
          //                   color: HexColor('#6C87AE'),
          //                 )),
          //                 TextSpan(
          //                   text: ' Blood Sugar Fasting\n',
          //                   style: TextStyle(
          //                       fontSize: 10.5,
          //                       fontWeight: FontWeight.w400,
          //                       color: HexColor('#6C87AE')),
          //                 ),
          //                 WidgetSpan(
          //                     child: Icon(
          //                   Icons.circle,
          //                   size: 10.5,
          //                   color: HexColor('#6C87AE'),
          //                 )),
          //                 TextSpan(
          //                   text: ' Liver Function Test\n',
          //                   style: TextStyle(
          //                       fontSize: 10.5,
          //                       fontWeight: FontWeight.w400,
          //                       color: HexColor('#6C87AE')),
          //                 ),
          //                 TextSpan(
          //                   text: 'View more',
          //                   style: TextStyle(
          //                       decoration: TextDecoration.underline,
          //                       fontSize: 10.5,
          //                       fontWeight: FontWeight.w400,
          //                       color: HexColor('#6C87AE')),
          //                 )
          //               ]),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 20,
          //       ),
          //       Container(margin: EdgeInsets.symmetric(horizontal: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               '\u20B9 2000/-',
          //               style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.w600,
          //                   color: HexColor('#1BA9B5')),
          //             ),
          //             Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          //               margin:
          //                   EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //               decoration: BoxDecoration(
          //                   border: Border.all(color: HexColor('#10217D')),
          //                   borderRadius: BorderRadius.circular(3)),
          //               child: Center(
          //                 child: Text(
          //                   "Add to cart",
          //                   style: TextStyle(
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w500,
          //                       color: HexColor('#10217D')),
          //                 ),
          //               ),
          //             )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    ));
  }
}
