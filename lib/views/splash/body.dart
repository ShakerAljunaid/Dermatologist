import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skindisease/Views/login/Screens/Welcome/welcome_screen.dart';
import 'package:skindisease/models/GeneralClasses/shared_prf_data.dart';

class SliderIntro extends StatefulWidget {
  SliderIntro({Key key}) : super(key: key);

  @override
  _SliderIntroState createState() => _SliderIntroState();
}

class _SliderIntroState extends State<SliderIntro> {
  int userId = 0;
  Future<SharedPreferences> _sPrefs = SharedPreferences.getInstance();

  Future<void> getUserNameFromSharedPrf() async {
    SharedPreferences prefs = await _sPrefs;
    if (prefs.get("UseCredentials") != null) {
      await getSharedPref().then((r) {
        if (r != null)
          setState(() {
            userId = int.parse(r.userID);
          });
      });
    }
  }

  int currentpage = 0;
  List listintro;
  var lang = "ar";

  @override
  void initState() {
    if (lang.toString() == "en") {
      listintro = [
        {
          "text": " Welcome to the dermatologist app",
          "image": "assets/images/a.jpg"
        },
        {
          "text": "We help you know the condition of your skin",
          "image": "assets/images/b.jpg"
        },
        {
          "text": "All you have to do is take a picture of the affected skin",
          "image": "assets/images/c.png"
        },
      ];
    } else {
      listintro = [
        {
          "text": " مرحبا بكم في تطبيق طبيب الجلدية",
          "image": "assets/images/a.jpg"
        },
        {
          "text": " نحن نساعدك على اكتشاف حالة جلدك",
          "image": "assets/images/b.jpg"
        },
        {
          "text": "كل ما عليك فعله هو التقاط صورة للجلد المصاب",
          "image": "assets/images/c.png"
        },
      ];
    }
    getUserNameFromSharedPrf();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  متغير يجمع بين العرض و الحجم
    var mdw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              flex: 2,
              child: PageView.builder(
                  //يتم استدعائها عند ما تتنقل  من صفحه لا صفحه
                  onPageChanged: (val) {
                    //عشان الدائره تتغير مع كل تغيير للصفحه
                    setState(() {
                      currentpage = val;
                    });
                  },
                  itemCount: listintro.length,
                  itemBuilder: (context, i) {
                    return TextAndImage(
                        list: listintro[i], mdw: mdw, lang: lang);
                  })),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  //Row عشان يكونو جمب بعض
                  Row(
                      // عشان يكونو في الوسط
                      mainAxisAlignment: MainAxisAlignment.center,

                      //عشان يفعلها لي على عدد الصفحات الي معي
                      children: List.generate(

                          //listintro.length ايشوف لي طولها
                          listintro.length,
                          (index) => buildControlPageView(index))),

                  // خلا الزر في الاسفل
                  Spacer(
                    flex: 5,
                  ),

                  userId == 0
                      ? FlatButton(
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          minWidth: mdw / 1.5,
                          child: Text(
                            'دخول',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ))
                      : FlatButton(
                          color: Colors.red[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          minWidth: mdw / 1.5,
                          child: Text(
                            'الرئيسية',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ))
        ],
      )),
    );
  }

//  يفعل عمليه الربط بين الصوره والكلام مع الدوائر index
//عشان يفعل انهم يتحركو مع بعض

  AnimatedContainer buildControlPageView(index) {
    return AnimatedContainer(

        //duration هو زمن الانميشن كم ايستغرق
        duration: Duration(milliseconds: 500),
        //الهامش الي بين الدوائر
        margin: EdgeInsets.symmetric(horizontal: 1),
        // اذا الصفحه الحاليه الدائره معرضه ماشي خاليها علر ماهي
        width: currentpage == index ? 20 : 5, //الطول

        height: 5, //العرض
        // الدوائر حق الحركه عشان نعرف في اي صفحه احنا
        decoration: BoxDecoration(
            color: Colors.red,

            // عشان تتوقع بشكل دائره
            borderRadius: BorderRadius.circular(2.5)));
  }
}

class TextAndImage extends StatelessWidget {
  final list;
  final mdw;
  final lang;

  const TextAndImage({Key key, this.list, this.mdw, this.lang})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            //هوامش
            margin: EdgeInsets.only(top: mdw / 6),

            //العنوان اسم التطبيق
            child: Text(
              "Darmatologist",
              //headline4 حجم الخط

              style: Theme.of(context).textTheme.headline4,
            ),
          ),

          // الفراغ بين الصور و العنوان
          SizedBox(height: 30),

          Container(
              // child: Text("${list['text']}",
              //    style: TextStyle(fontSize: 21, color: Colors.grey[800]))),
              child: Text("${list['text']}")),

          SizedBox(height: 20),
          Image.asset(
            "${list['image']}",
            width: mdw / 1.5,
          )
        ],
      ),
    );
  }
}


// Text("$list['text']"),
