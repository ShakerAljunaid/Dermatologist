import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:skindisease/models/GeneralClasses/NetworkCheck.dart';
import 'package:skindisease/models/GeneralClasses/dialogs_alerts.dart';
import 'package:skindisease/models/GeneralClasses/shared_prf_data.dart';
import 'package:skindisease/models/UserDiseaseHistory/detailsModel.dart';
import 'package:skindisease/models/UserDiseaseHistory/masterModel.dart';
import 'details.dart';

class UserHistory extends StatefulWidget {
  UserHistory({Key key}) : super(key: key);

  @override
  _UserHistory createState() => _UserHistory();
}

class _UserHistory extends State<UserHistory> {
  List<MasterModel> historyMasterData = new List();
  getHistoryData() async {
    if (await NetworkCheck().checkInternetConnection()) {
      await getSharedPref().then((r) async {
        var msg = '';
        try {
          await Requests.post(
                  "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/getUserHistory.php",
                  timeoutSeconds: 120,
                  body: {"userId": r.userID},
                  bodyEncoding: RequestBodyEncoding.FormURLEncoded)
              .then((v) async {
            msg = v.content();
            if (v.json() != null) {
              var tablesData = json.decode(v.content());
              List<MasterModel> historyMasters = new List();
              for (var hm in tablesData) {
                var h = new MasterModel.fromMap(hm);
                historyMasters.add(h);
              }
              setState(() {
                historyMasterData = historyMasters;
              });
            }
          });
        } catch (error) {
          print('Here is error' + error);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHistoryData();
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
        title: const Text(
          'السجل الطبي',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: historyMasterData.length,
        itemBuilder: (context, index) {
          return Card(
            //                           <-- Card widget
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text(historyMasterData[index].createdAt),
              onTap: () async {
                var msg = '';
                if (await NetworkCheck().checkInternetConnection()) {
                  try {
                    await Requests.post(
                            "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/gethistorydetails.php",
                            timeoutSeconds: 120,
                            body: {"masterId": historyMasterData[index].id},
                            bodyEncoding: RequestBodyEncoding.FormURLEncoded)
                        .then((v) async {
                      msg = v.content();
                      if (v.json() != null) {
                        var tablesData = json.decode(v.content());
                        List<DetailsModel> historyDetails = new List();
                        for (var hd in tablesData) {
                          var d = new DetailsModel.fromMap(hd);
                          historyDetails.add(d);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return UserHistoryDetails(historyDetails,
                                  historyMasterData[index].createdAt);
                            },
                          ),
                        );
                      } else {
                        print('Here is an error:' + msg);
                        await DialogsAlerts.dialogsAlerts.wrongAlert(
                            context, 'خطأ', 'الرجاء المحاولة مرة اخرى!');
                      }
                    });
                  } catch (error) {
                    print('Here is an error:' + error);
                    await DialogsAlerts.dialogsAlerts.wrongAlert(
                        context, 'خطأ', 'الرجاء المحاولة مرة اخرى!');
                  }
                } else {
                  await DialogsAlerts.dialogsAlerts.wrongAlert(
                      context, 'خطأ', 'الرجاء التحقق من وجود انترنت!');
                }
              },
            ),
          );
        },
      ),
    );
  }
}
