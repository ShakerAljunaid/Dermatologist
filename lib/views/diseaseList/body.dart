import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:skindisease/models/GeneralClasses/NetworkCheck.dart';
import 'package:skindisease/models/GeneralClasses/dialogs_alerts.dart';
import 'package:skindisease/models/disease_details.dart';
import 'package:skindisease/views/disease/defintion.dart';

class DiseaseList extends StatelessWidget {
  DiseaseList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disease = [
      'Acne Closed Comedo',
      'Acne Cystic',
      'Acne Excoriated',
      'Acne Infantile',
      'Acne Open Comedo',
      'Acne Pustular',
      'Acne Scar',
      'Dyshidrotic eczema',
      'Eczema Acute',
      'Eczema Areola',
      'Eczema Asteatotic',
      'Eczema Chronic',
      'Eczema Impetiginized',
      'Eczema Nummular',
      'Eczema Subacute',
      'Eczema Trunk Generalized',
      'Acute Paronychia',
      'Chronic Paronychia',
      'Distal Subungual Onychomycosis',
      'Eczema nail',
      'Habit Tic Deformity',
      'Hang Nail',
      'Median Nail Dystrophy',
      'Mucous Cyst',
      'Onycholysis',
      'Pseudomonas',
      'Psoriasis',
      'Ridging Beading',
      'Trauma',
      'Not human skin',
      'Healthy skin'
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'الأمراض الجلدية',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: disease.length,
        itemBuilder: (context, index) {
          return Card(
            //                           <-- Card widget
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text(disease[index]),
              onTap: () async {
                if (await NetworkCheck().checkInternetConnection()) {
                  try {
                    await Requests.post(
                            "http://skindatabase-001-site1.gtempurl.com/serversidecalls/api/search4disease.php",
                            timeoutSeconds: 120,
                            body: {"diseaseName": disease[index]},
                            bodyEncoding: RequestBodyEncoding.FormURLEncoded)
                        .then((v) async {
                      if (v.json() != null) {
                        var dm = DiseaseDetailsModel.fromMap(v.json());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DiseaseDetails(dm);
                            },
                          ),
                        );
                      } else {
                        await DialogsAlerts.dialogsAlerts.wrongAlert(
                            context, 'خطأ', 'الرجاء المحاولة مرة اخرى!');
                      }
                    });
                  } catch (error) {
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
