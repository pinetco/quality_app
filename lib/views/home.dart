import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/controllers/store_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var bottomCtrl = Get.put(BottomNavigationController());
  var storeCtrl = Get.put(StoreController());

  AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // List itemList = [
  //   {'title': 'Dr. Albert Cooper', 'image': user1, 'designation': 'Royal Londion Hospital', 'rating_image': badEmoji, 'rating_count': 10, 'star_rating': 1.5},
  //   {'title': 'Fabrizio', 'image': user1, 'designation': 'Care taker', 'rating_image': goodEmoji, 'rating_count': 14, 'star_rating': 1.5},
  //   {'title': 'Imam Tahir', 'image': user1, 'designation': 'Care taker', 'rating_image': veryGoodEmoji, 'rating_count': 50, 'star_rating': 1.5},
  //   {'title': 'Dina', 'price': '120', 'image': user1, 'designation': 'Care taker', 'rating_image': okEmoji, 'rating_count': 3, 'star_rating': 1.5},
  //   {'title': 'Kaja', 'image': user8, 'designation': 'Care taker', 'rating_image': goodEmoji, 'rating_count': 23, 'star_rating': 1.5},
  //   {'title': 'Pascal Kramp', 'image': user1, 'designation': 'Care taker', 'rating_image': sadEmoji, 'rating_count': 2, 'star_rating': 1.5},
  //   {'title': 'Patrick', 'image': user1, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 30, 'star_rating': 1.5},
  //   {'title': 'Nitin Gadhiya', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Banana', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Mango', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Apple', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Banana', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Mango', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Apple', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1, 'star_rating': 1.5},
  //   {'title': 'Banana', 'image': user8, 'designation': 'Care taker', 'rating_image': badEmoji, 'rating_count': 1.2, 'star_rating': 1.5},
  //   {'title': 'Mango', 'image': user8, 'designation': 'Care taker', 'rating_image': goodEmoji, 'rating_count': 4.5, 'star_rating': 1.5},
  //   {'title': 'Apple', 'image': user1, 'designation': 'Care taker', 'rating_image': veryGoodEmoji, 'rating_count': 5, 'star_rating': 1.5},
  //   {'title': 'Orange', 'image': user8, 'designation': 'Care taker', 'rating_image': sadEmoji, 'rating_count': 2.1, 'star_rating': 1.5},
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF7F8FA),
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        //elevation: 0,
        title: Text("Quality Control"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                MdiIcons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                final storage = GetStorage();
                storage.remove(Session.authToken);
                Get.offAndToNamed(AppRouter.login);
              })
        ],
      ),
      body: LoadingComponent(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                    // child: CustomTextFormField(
                    //   hintText: 'Search Contact',
                    //   prefixIcon: Icon(MdiIcons.magnify),
                    //   fillColor: Colors.grey.withOpacity(0.1),
                    // ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                          left: screenWidth(10),
                          right: screenWidth(10),
                          // top: screenWidth(10),
                        ),
                        child: GetBuilder<StoreController>(
                          builder: (_dx) => StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: _dx.itemList.length,
                            padding: EdgeInsets.only(
                              top: screenWidth(20),
                              bottom: screenHeight(20),
                              left: screenHeight(10),
                              right: screenHeight(10),
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              dynamic item = _dx.itemList[index];
                              dynamic email = item['email'];
                              dynamic imageName = item['profile_photo_url'];
                              String name = item['name'];
                              String phone = item['phone'];
                              int empId = item['id'];
                              // String ratingImage = item['rating_image'];
                              // dynamic ratingCount = item['rating_count'];
                              // dynamic ratingStar = item['star_rating'];

                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRouter.reviewSubmission, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.grey[300]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 10.0,
                                        spreadRadius: 1,
                                        offset: Offset(
                                          5.0, // Move to right 10  horizontally
                                          5.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  // padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: screenWidth(20.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(screenWidth(190)),
                                          child: Image.network(
                                            imageName,
                                            height: screenWidth(90),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenHeight(10),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth(10)),
                                        child: Text(
                                          name.toString(),
                                          style: h3,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      // Text(
                                      //   email.toString(),
                                      //   style: bodyStyle5.copyWith(color: Colors.black54),
                                      // ),
                                      Text(
                                        phone.toString(),
                                        style: bodyStyle5.copyWith(color: Colors.black54),
                                      ),
                                      SizedBox(height: screenWidth(20)),
                                      // SizedBox(height: screenWidth(5)),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Image.asset(
                                      //       ratingImage,
                                      //       height: screenWidth(20),
                                      //     ),
                                      //     SizedBox(width: screenWidth(5)),
                                      //     Text(
                                      //       '($ratingStar)',
                                      //       style: bodyStyle5,
                                      //     ),
                                      //     SizedBox(width: screenWidth(5)),
                                      //     Text(
                                      //       '$ratingCount ratings',
                                      //       style: bodyStyle5,
                                      //     ),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            },
                            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                            mainAxisSpacing: screenWidth(20),
                            crossAxisSpacing: screenWidth(20),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
