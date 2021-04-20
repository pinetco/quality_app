import 'package:quality_app/controllers/bottom_navigation_controller.dart';
import 'package:quality_app/packages/input_package.dart';
import 'package:flutter/material.dart';
import 'package:quality_app/packages/config_package.dart';
import 'package:quality_app/controllers/store_controller.dart';

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

  Widget personDetailCard(item, index, status) {
    dynamic email = item['email'];
    dynamic imageName = item['profile_photo_url'];
    String name = item['name'].toString();
    String phone = item['phone'].toString();
    int empId = item['id'];
    return Padding(
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
                    status == '' ? '2014-02-23' : '2020-03-04',
                    style: bodyStyle6.copyWith(color: grayColor),
                  ),
                ],
              ),
            ),
            if (status == '')
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: CustomButton(
                    title: 'Rate',
                    width: screenWidth(80),
                    padding: screenWidth(5),
                    radius: screenWidth(5),
                    style: bodyStyle6.copyWith(color: Colors.white),
                    onTap: () {
                      navigateReviewScreen(empId, name, email, phone, imageName);
                    }),
              ),
            /* if (index == 2)
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: CustomButton(
                    title: 'Rated',
                    color: Colors.white,
                    border: Border.all(width: 1, color: primaryDarkColor),
                    width: screenWidth(80),
                    padding: screenWidth(5),
                    radius: screenWidth(5),
                    style: bodyStyle6.copyWith(color: primaryDarkColor),
                    onTap: () {
                      navigateReviewScreen(empId, name, email, phone, imageName);
                    }),
              ),*/
            if (status == 'working')
              Container(
                padding: EdgeInsets.only(right: screenWidth(10.0)),
                child: Text('Working', style: bodyStyle6.copyWith(color: Colors.green)),
              ),
          ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth(20), right: screenWidth(10)),
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
                              NotificationHeaderIcon(),
                              SizedBox(
                                width: screenWidth(15),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     Get.toNamed(AppRouter.profile);
                              //   },
                              //   child: Image.asset(
                              //     userIcon,
                              //     width: screenWidth(20),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight(20)),
                                    Align(alignment: Alignment.topLeft, child: Text('Survey', style: h4)),
                                    SizedBox(height: screenHeight(4)),
                                    Text(
                                      'Thank you for being our loyal customer. As you know quality and customer satisfaction is our top priority. It would be awesome if you could fill out our quarterly survey.',
                                      style: bodyStyle6.copyWith(color: grayColor),
                                    ),
                                    SizedBox(height: screenHeight(15)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                child: CustomButton(
                                  title: "Quarterly Survey",
                                  suffixIcon: Image.asset(
                                    rightArrowIcon,
                                    width: screenWidth(20),
                                  ),
                                  onTap: () {
                                    Get.toNamed(AppRouter.surveyInfo);
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight(25)),
                              Divider(
                                height: screenHeight(5),
                                color: dividerColor,
                                thickness: 5,
                              ),
                              SizedBox(height: screenHeight(25)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                child: Text(
                                  'Working Care Giver',
                                  style: h5,
                                ),
                              ),
                              GetBuilder<StoreController>(
                                builder: (_dx) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _dx.itemList.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) return personDetailCard(_dx.itemList[index], index, 'working');
                                    return Container();
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight(25)),
                              Divider(
                                height: screenHeight(5),
                                color: dividerColor,
                                thickness: 5,
                              ),
                              SizedBox(height: screenHeight(25)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                                child: Text(
                                  'Finished Visit',
                                  style: h5,
                                ),
                              ),
                              GetBuilder<StoreController>(
                                builder: (_dx) => ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _dx.itemList.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0 || index == 1 || index == 2) return personDetailCard(_dx.itemList[index], index, '');
                                    return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /* Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                      child: Text(
                        'Working Vist',
                        style: h6,
                      ),
                    ),*/
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                    //   // child: CustomTextFormField(
                    //   //   hintText: 'Search Contact',
                    //   //   prefixIcon: Icon(MdiIcons.magnify),
                    //   //   fillColor: Colors.grey.withOpacity(0.1),
                    //   // ),
                    // ),
                    /*Expanded(
                      child: Container(
                          child: GetBuilder<StoreController>(
                        builder: (_dx) => ListView.builder(
                          itemCount: _dx.itemList.length,
                          itemBuilder: (context, index) {
                            if (index == 0 || index == 1 || index == 2) return personDetailCard(_dx.itemList[index], index);
                            return Container();
                          },
                        ),
                      )),
                    ),*/

                    /*Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth(20)),
                      child: Text(
                        'Unrated Vist',
                        style: h6,
                      ),
                    ),*/
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
