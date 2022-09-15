import 'package:flutter/material.dart';
import 'package:skindisease/models/disease_details.dart';

class DiseaseDetails extends StatefulWidget {
  final DiseaseDetailsModel dm;
  DiseaseDetails(this.dm);
  @override
  State<StatefulWidget> createState() {
    return _DiseaseDetailsState();
  }
}

class _DiseaseDetailsState extends State<DiseaseDetails> {
  int _currentIndex = 0;
  List<Widget> _children = new List();
  @override
  void initState() {
    super.initState();
    setState(() {
      _children = [
        Container(
            child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text(('  التعريف:'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(widget.dm.definition ?? '',
                    style: TextStyle(fontSize: 25)))
          ],
        )),
        Container(
            child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text((' الأعراض:'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(widget.dm.symptoms ?? '',
                    style: TextStyle(fontSize: 25)))
          ],
        )),
        Container(
            child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text((' الأسباب:'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(widget.dm.causes ?? '',
                    style: TextStyle(fontSize: 25)))
          ],
        )),
        Container(
            child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text((' العلاج:'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(widget.dm.treatment ?? '',
                    style: TextStyle(fontSize: 25)))
          ],
        )),
        Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text((' النصائح:'),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
            Align(
                alignment: Alignment.centerRight,
                child: Text(widget.dm.recommendations ?? '',
                    style: TextStyle(fontSize: 25)))
          ],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'وصف المرض - ${widget.dm.name}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [_children[_currentIndex]],
              ))),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.black),
            title: Text('التعريف'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sick, color: Colors.black),
            title: Text('الأعراض'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning, color: Colors.black),
            title: Text('الأسباب'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services, color: Colors.black),
              title: Text('العلاج')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: Text('النصائح')),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
