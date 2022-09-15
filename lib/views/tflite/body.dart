import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:requests/requests.dart';
import 'package:skindisease/models/GeneralClasses/NetworkCheck.dart';
import 'package:skindisease/models/GeneralClasses/dialogs_alerts.dart';
import 'package:skindisease/models/GeneralClasses/shared_prf_data.dart';
import 'package:skindisease/models/GeneralClasses/userModel.dart';
import 'package:skindisease/models/disease_details.dart';
import 'package:skindisease/views/disease/defintion.dart';
import 'package:tflite/tflite.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  File _imageFile;
  List _classifiedResult;
  User user;
  int userId;
  Future<void> getUserNameFromSharedPrf() async {
    await getSharedPref().then((r) {
      print(r.userName);
      setState(() {
        user = r;
        userId = int.parse(r.userID);
      });
    });
  }

  ProgressDialog pr;

  _detailsDialog(String msgTitle, String msgContent) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msgTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msgContent),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('تم'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadImageModel();
    this.getUserNameFromSharedPrf().then((value) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.update(
      progress: 50.0,
      message: "...جاري اضافة البيانات الى سجلك الطبي",
      progressWidget: Container(
          padding: EdgeInsets.all(9.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            'Dermatologist',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 10),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                spreadRadius: 2,
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: (_imageFile != null)
                              ? Image.file(_imageFile)
                              : Image.asset("assets/images/sUFH1Aq.png")),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                onPressed: () {
                                  selectImage();
                                },
                                child: Icon(Icons.image_search)),
                            RaisedButton(
                                onPressed: () {
                                  getImageFromCamera();
                                },
                                child: Icon(Icons.camera))
                          ]),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Column(
                          children: _classifiedResult != null
                              ? _classifiedResult.map((result) {
                                  return Card(
                                    elevation: 0.0,
                                    color: Colors.red[600],
                                    child: Container(
                                        width: 300,
                                        margin: EdgeInsets.all(10),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (await NetworkCheck()
                                                .checkInternetConnection()) {
                                              try {
                                                await Requests.post(
                                                        "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/search4disease.php",
                                                        timeoutSeconds: 120,
                                                        body: {
                                                          "diseaseName":
                                                              result["label"]
                                                        },
                                                        bodyEncoding:
                                                            RequestBodyEncoding
                                                                .FormURLEncoded)
                                                    .then((v) async {
                                                  if (v.json() != null) {
                                                    var dm = DiseaseDetailsModel
                                                        .fromMap(v.json());

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return DiseaseDetails(
                                                              dm);
                                                        },
                                                      ),
                                                    );
                                                  } else {
                                                    await DialogsAlerts
                                                        .dialogsAlerts
                                                        .wrongAlert(
                                                            context,
                                                            'خطأ',
                                                            'الرجاء المحاولة مرة اخرى!');
                                                  }
                                                });
                                              } catch (error) {
                                                await DialogsAlerts
                                                    .dialogsAlerts
                                                    .wrongAlert(context, 'خطأ',
                                                        'الرجاء المحاولة مرة اخرى!');
                                              }
                                            } else {
                                              await DialogsAlerts.dialogsAlerts
                                                  .wrongAlert(context, 'خطأ',
                                                      'الرجاء التحقق من وجود انترنت!');
                                            }
                                          },
                                          child: Center(
                                            child: Text(
                                              "${result["label"]} :  ${(result["confidence"] * 100).toStringAsFixed(1)}%",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )),
                                  );
                                }).toList()
                              : [],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]))));
  }

  Future loadImageModel() async {
    Tflite.close();
    String result;
    result = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset:
            true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false);
    print(result);
  }

  Future selectImage() async {
    final picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.gallery, maxHeight: 300);
    classifyImage(image);
  }

  Future getImageFromCamera() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);

    classifyImage(image);
  }

  Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    print("classification start $image");
    final List result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("classification done");
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
        _classifiedResult = result;
        add2UserDiseaseHistoryDatabase();
      } else {
        print('No image selected.');
      }
    });
  }

  add2UserDiseaseHistoryDatabase() async {
    if (await NetworkCheck().checkInternetConnection()) {
      if (await NetworkCheck().checkInternetConnection()) {
        var data = {"userId": userId};

        pr.show();
        await Requests.post(
                "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/createUserHistoryDiseaseMaster.php",
                timeoutSeconds: 120,
                body: data,
                bodyEncoding: RequestBodyEncoding.FormURLEncoded)
            .then((c) async {
          print('out');
          print(c.content());
          var masterId = int.parse(c.content());
          if (masterId > 0) {
            var diseaseHistoryDetails = new List();
            for (var dh in _classifiedResult) {
              var d = {
                "diseaseName": dh["label"],
                "ratio": (dh["confidence"] * 100).toStringAsFixed(1)
              };

              diseaseHistoryDetails.add((d));
            }

            var data = {
              "userId": userId,
              "masterId": masterId,
              "details": jsonEncode(diseaseHistoryDetails)
            };
            await Requests.post(
                    "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/createUserHistoryDiseaseDetails.php",
                    body: data,
                    bodyEncoding: RequestBodyEncoding.FormURLEncoded,
                    timeoutSeconds: 180)
                .then((v) async {
              try {
                if (int.parse(v.content()) > 0) {
                  print('Details out:' + v.content());

                  if (pr.isShowing()) pr.hide();
                  await DialogsAlerts.dialogsAlerts.wrongAlert(context,
                      'نجحت العملية', 'تم اضافة البيانات الى سجلك الطبي!');
                } else {
                  if (pr.isShowing()) pr.hide();
                  await DialogsAlerts.dialogsAlerts.wrongAlert(context, 'خطأ',
                      'فشل تسجيل الدخول،الرجاء التأكد من البيانات!');
                }
              } catch (error) {
                print('Here is the error :' + v.content());
                if (pr.isShowing()) pr.hide();
                await DialogsAlerts.dialogsAlerts.wrongAlert(
                    context, 'خطأ', 'فشل اضافة البيانات الى سجلك الطبي!');
              }
            });
          } else {
            await DialogsAlerts.dialogsAlerts.wrongAlert(
                context, 'خطأ', 'فشل اضافة البيانات الى سجلك الطبي!');
          }
        });
      } else {
        if (pr.isShowing()) pr.hide();
        _detailsDialog('خطأ', 'الرجاء التحقق من وجود انترنت!');
      }
    }
  }
}
