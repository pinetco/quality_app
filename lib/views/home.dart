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

  Widget personDetailCard(item) {
    dynamic email = item['email'];
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    String phone = item['phone'].toString();
    int empId = item['id'];
    return InkWell(
      onTap: () {
        navigateReviewScreen(empId, name, email, phone, imageName);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(20)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: screenWidth(5.0)),
          decoration: BoxDecoration(border: Border.all(width: 1, color: deactivateColor), borderRadius: BorderRadius.circular(screenWidth(10))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth(8), horizontal: screenWidth(10)),
                child: Container(
                    width: screenWidth(60.0),
                    height: screenWidth(60.0),
                    decoration: new BoxDecoration(shape: BoxShape.circle, image: new DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageName)))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      name,
                      style: bodyStyle5.copyWith(color: black22Color),
                    ),
                    Text(
                      phone,
                      style: bodyStyle6.copyWith(color: grayColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: CustomButton(
                    title: 'Rate',
                    width: screenWidth(80),
                    padding: screenWidth(5),
                    radius: screenWidth(5),
                    style: bodyStyle7.copyWith(color: Colors.white),
                    onTap: () {
                      navigateReviewScreen(empId, name, email, phone, imageName);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateReviewScreen(empId, name, email, phone, userImage) {
    Get.toNamed(AppRouter.reviewSubmission, arguments: {'id': empId, 'name': name, 'email': email, 'phone': phone, 'userImage': userImage});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Align(
      //     alignment: Alignment.topLeft,
      //     child: Column(
      //       children: [
      //         Text(
      //           "Quality Control",
      //           style: h1.copyWith(color: black22Color),
      //           textAlign: TextAlign.left,
      //         ),
      //         Text(
      //           "Your review is making a difference!",
      //           style: bodyStyle4.copyWith(color: black22Color),
      //           textAlign: TextAlign.left,
      //         ),
      //       ],
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //         icon: Icon(
      //           MdiIcons.logoutVariant,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           storeCtrl.logout();
      //         })
      //   ],
      // ),
      body: SafeArea(
        child: LoadingComponent(
          child: Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GetBuilder<StoreController>(builder: (_dx) {
                                if (storeCtrl.userInfo != null &&
                                    storeCtrl.userInfo['franchisee'] != null &&
                                    storeCtrl.userInfo['franchisee']['logo_url'] != null)
                                  return Image.network(
                                    storeCtrl.userInfo['franchisee']['logo_url'],
                                    height: screenHeight(50),
                                  );
                                return Text(
                                  'Quality Control',
                                  style: h1,
                                );
                              }),
                              Spacer(),
                              Image.asset(
                                notificationIcon,
                                width: screenWidth(20),
                              ),
                              SizedBox(
                                width: screenWidth(15),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(AppRouter.profile);
                                },
                                child: Image.asset(
                                  userIcon,
                                  width: screenWidth(20),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your review is making a difference!',
                              style: bodyStyle4,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                          child: GetBuilder<StoreController>(
                        builder: (_dx) => ListView.builder(
                          itemCount: _dx.itemList.length,
                          itemBuilder: (context, index) {
                            return personDetailCard(_dx.itemList[index]);
                          },
                        ),

                        /*  StaggeredGridView.countBuilder(
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
                            ),*/
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
