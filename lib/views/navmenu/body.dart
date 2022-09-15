import 'package:flutter/material.dart';

import 'package:skindisease/models/GeneralClasses/shared_prf_data.dart';
import 'package:skindisease/models/GeneralClasses/userModel.dart';
import 'package:skindisease/views/diseaseList/body.dart';
import 'package:skindisease/views/splash/body.dart';
import 'package:skindisease/views/tflite/body.dart';
import 'package:skindisease/views/userDiseaseHistory/body.dart';

class NavigationPageScreen extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  User user;
  String userName = "";
  int userId;
  final Color green = Color(0xFF1E8161);
  Future<void> getUserNameFromSharedPrf() async {
    await getSharedPref().then((r) {
      print(r.userName);
      setState(() {
        user = r;
        userName = r.userName;
      });
    });
  }

  @override
  void initState() {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

    super.initState();

    this.getUserNameFromSharedPrf().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawer(),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Image.asset(
                      "assets/images/logo.gif",
                      width: screenWidth(context, dividedBy: 6),
                      height: screenHeight(context, dividedBy: 20),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, right: 10),
                      child: Text(
                        'الرئيسية',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Icon(
                      Icons.ac_unit,
                      size: 75,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.ac_unit,
                      size: 75,
                      color: Colors.white,
                    )
                    // Image.asset(
                    //   "assets/how-work3.png",
                    //   width: 52.0,
                    // )
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Text(
                  'اهلاً بك ' +
                      (userName.length < 20
                          ? userName.substring(0, userName.length).toUpperCase()
                          : userName.substring(0, 18).toUpperCase()),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Divider(),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: Wrap(
                    spacing: 20,
                    runSpacing: 20.0,
                    children: <Widget>[
                      SizedBox(
                        width: screenWidth(context, dividedBy: 2.4),
                        height: screenHeight(context, dividedBy: 4.5),
                        child: Card(
                          color: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => IndexPage()));
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.image_search,
                                    size: 90.0,
                                    color: Colors.red[600],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "تشخيص",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 2.4),
                        height: screenHeight(context, dividedBy: 4.5),
                        child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DiseaseList()));
                              },
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.red[600],
                                      size: 90.0,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "قائمة الامراض",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              )),
                            )),
                      ),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 2.4),
                        height: screenHeight(context, dividedBy: 4.5),
                        child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserHistory()));
                              },
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.history,
                                      size: 90.0,
                                      color: Colors.red[600],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "سجلك الطبي",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              )),
                            )),
                      ),
                      SizedBox(
                        width: screenWidth(context, dividedBy: 2.4),
                        height: screenHeight(context, dividedBy: 4.5),
                        child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SliderIntro()));
                              },
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.info,
                                      size: 90.0,
                                      color: Colors.red[600],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "عن التطبيق",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ],
                                ),
                              )),
                            )),
                      ),
                      SizedBox(height: screenHeight(context, dividedBy: 3)),
                      Divider(),
                      Container(
                        child: ListTile(
                            dense: true,
                            title: Text("Appdermatologist"),
                            trailing: Text(
                              "Version 1.0.0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            leading: Image.asset(
                              "assets/images/logo.gif",
                              width: screenWidth(context, dividedBy: 5),
                            )),
                      )
                    ],
                  )))
            ])));
  }

  Size screenSize(BuildContext context, {double dividedBy = 1}) {
    return MediaQuery.of(context).size / dividedBy;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }
}
