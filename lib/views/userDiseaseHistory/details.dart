import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:skindisease/models/GeneralClasses/NetworkCheck.dart';
import 'package:skindisease/models/GeneralClasses/dialogs_alerts.dart';
import 'package:skindisease/models/UserDiseaseHistory/detailsModel.dart';
import 'package:skindisease/models/disease_details.dart';
import 'package:skindisease/views/disease/defintion.dart';

class UserHistoryDetails extends StatefulWidget {
  UserHistoryDetails(this.details, this.createdAt);
  final List<DetailsModel> details;
  final String createdAt;
  @override
  _UserHistoryDetails createState() => _UserHistoryDetails();
}

class _UserHistoryDetails extends State<UserHistoryDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'تفاصيل فحص تاريخ ' + widget.createdAt,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: widget.details != null
              ? widget.details.map((result) {
                  return Align(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 0.0,
                        color: Colors.red[600],
                        child: Container(
                            alignment: Alignment.topLeft,
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
                                              "diseaseName": result.diseaseName
                                            },
                                            bodyEncoding: RequestBodyEncoding
                                                .FormURLEncoded)
                                        .then((v) async {
                                      if (v.json() != null) {
                                        var dm = DiseaseDetailsModel.fromMap(
                                            v.json());

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DiseaseDetails(dm);
                                            },
                                          ),
                                        );
                                      } else {
                                        await DialogsAlerts.dialogsAlerts
                                            .wrongAlert(context, 'خطأ',
                                                'الرجاء المحاولة مرة اخرى!');
                                      }
                                    });
                                  } catch (error) {
                                    await DialogsAlerts.dialogsAlerts
                                        .wrongAlert(context, 'خطأ',
                                            'الرجاء المحاولة مرة اخرى!');
                                  }
                                } else {
                                  await DialogsAlerts.dialogsAlerts.wrongAlert(
                                      context,
                                      'خطأ',
                                      'الرجاء التحقق من وجود انترنت!');
                                }
                              },
                              child: Center(
                                child: Text(
                                  "${result.diseaseName} :  ${(result.ratio)}%",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ));
                }).toList()
              : [],
        ),
      )),
    );
  }
}
