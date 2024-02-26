import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testquots/controller.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isPressed = false;
  QuotationController quotationController = Get.put(QuotationController());

  @override
  void initState() {
    super.initState();
    // bibleController.fetchaBibleData();

    // Fetch data when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height;
    Color iconColor = isPressed
        ? Colors.red.shade400
        : Colors.white70; // Change colors as needed

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(254, 16, 23, 24),
        body: Stack(
          children: [

            Transform.scale(
              scale: 3.5,
              child: Image.asset(
                "assets/imags/back-01.png",
                //  "assets/imags/back-01.png",
                height: 900,
                width: 900,
              ),
            ),
            layerOverlay(Colors.black38),
            
            Obx(() {
              if (quotationController.isLoading.value) {
                return Center(
                    child:
                        CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(254, 16, 23, 24),
                        ) // Show a loading indicator
                    );
              } else {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: quotationController.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotationController.quotes[index];

                    return Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: widthS * 0.01),
                            child: Text(
                              quote.text,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: heightS * 0.035,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              //quote.text,
                              "- ${quote.byName} -",
                              style: GoogleFonts.caveat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 218, 218, 218)),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Share.share(
                                        '${quote.text} com.example.motivationalmode',
                                        subject: '${quote.text}');
                                    debugPrint("share");
                                  },
                                  icon: Transform.rotate(
                                    angle: 270 * 3.1415926535 / 180,
                                    child: Icon(
                                      Icons.logout,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPressed = !isPressed;
                                    });
                                    debugPrint("love");
                                  },
                                  icon: Icon(Icons.favorite,
                                      size: 35, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 65),
                child: Text(
                  'Motivation',
                  style: GoogleFonts.inter(
                    fontSize: heightS * 0.028,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 65, right: 20),
            //     child: InkWell(
            //       onTap: () {
            //         debugPrint("Call 1");
            //         Get.toNamed("/eleven");
            //       },
            //       child: Container3(
            //         child: Image.asset(
            //           "assets/imags/Crown-i.png",
            //           height: 20,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 50,
            //   ),
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: heightS * 0.06),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           InkWell(
            //             onTap: () {
            //               debugPrint("Call 1");
            //               Get.toNamed("/profile");
            //             },
            //             child: Container3(
            //               child: Image.asset(
            //                 "assets/imags/dash-i.png",
            //                 height: 20,
            //               ),
            //             ),
            //           ),
            //           // InkWell(
            //           //   onTap: () {
            //           //     debugPrint("Call 2");
            //           //     Get.toNamed("/eleven");
            //           //   },
            //           //   child: Container3(
            //           //     child: Icon(
            //           //       Icons.draw,
            //           //       color: Colors.white,
            //           //     ),
            //           //   ),
            //           // ),
            //           // InkWell(
            //           //   onTap: () {
            //           //     debugPrint("Call 3");
            //           //     //Get.toNamed("/profile");
            //           //   },
            //           //   child: Container3(
            //           //     child: Image.asset(
            //           //       "assets/imags/user-i.png",
            //           //       height: 20,
            //           //     ),
            //           //   ),
            //           // ),
            //           // InkWell(
            //           //   onTap: () {
            //           //     debugPrint("Call 4");
            //           //     Get.toNamed("/category");
            //           //   },
            //           //   child: Container3(
            //           //     child: Icon(
            //           //       Icons.menu_book,
            //           //       color: Colors.white,
            //           //     ),
            //           //   ),
            //           // ),
            //           InkWell(
            //             onTap: () {
            //               debugPrint("Call 6");
            //               storageController.saveGitaPressValue(true);
            //               storageController.saveBiblePressValue(false);
            //               gitaBookController.isAPIcall = true;
            //               gitaChapterController.verseList.clear();
            //               gitaBookController.verseListAll.clear();
            //               gitaBookController.verseListAll.isEmpty
            //                   ? debugPrint("data is clear form Verce")
            //                   : debugPrint("");

            //               // storageController.saveMyBooleanVariable(true);
            //               //
            //               //if (storageController.getLogin()) {
            //                if (storageController.getLogin() && storageController.getPaid() == true) {
            //                 Get.toNamed("/gitabookpage");
            //                 gitaBookController.fetchGeetaData();
            //               } else {
            //                 Get.toNamed("/payment");
            //               }
            //             },
            //             child: Container3(
            //                 child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Image.asset(
            //                   "assets/imags/om-i.png",
            //                   height: 18,
            //                 ),
            //                 SizedBox(
            //                   height: 2,
            //                 ),
            //                 Text(
            //                   "Gita",
            //                   style: GoogleFonts.inter(
            //                       color: white,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: heightS * 0.012),
            //                 ),
            //               ],
            //             )),
            //           ),
            //           InkWell(
            //             onTap: () {

            //               storageController.saveBiblePressValue(true);
            //               storageController.saveGitaPressValue(false);
            //               bibleController.bibleAll.clear();
            //               bibleController.isapicall = true;
            //              // if (storageController.getLogin()) {
            //              if (storageController.getLogin() && storageController.getPaid() == true) {

            //                 Get.toNamed("/bibleBook");
            //                 bibleController.fetchaBibleData();
            //               } else {
            //                 Get.toNamed("/payment");
            //               }
            //             },
            //             child: Container3(
            //                 child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Image.asset(
            //                   "assets/imags/cristh-i.png",
            //                   height: 18,
            //                 ),
            //                 SizedBox(
            //                   height: 1,
            //                 ),
            //                 Text(
            //                   "Bible",
            //                   style: GoogleFonts.inter(
            //                       color: white,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: heightS * 0.012),
            //                 ),
            //               ],
            //             )),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding:  EdgeInsets.only(top: heightS*0.09,right: widthS*0.05),
              child: Align(alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/manue");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 49, 22, 90),
                      borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.brunch_dining_sharp,color: Colors.white,),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container layerOverlay(Color color) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: color,
  );
}
