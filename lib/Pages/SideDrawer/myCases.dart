import 'package:Lawyer/Models/case.dart';
import 'package:Lawyer/Models/lawyer.dart';
import 'package:Lawyer/Models/user.dart';
import 'package:Lawyer/Widgets/caseCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyCasesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCasesPageState();
  }
}

class MyCasesPageState extends State<MyCasesPage> {
  List<Case> _casesList = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("My cases"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('case').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SpinKitChasingDots(
                color: Colors.brown[400],
              );
            } else {
              this._casesList = [];
              snapshot.data.documents.forEach((doc) {
                if (doc['assignedLawyer'] == Provider.of<Lawyer>(context).lawyerId) {
                  Case _case = new Case(
                    assigned: doc['assigned'],
                    assignedLawyer: doc['assignedLawyer'],
                    caseNumber: doc['caseNumber'],
                    caseType: doc['caseType'],
                    information: doc['information'],
                    owner: User(uid: doc['owner']),
                    state: doc['state'],
                    year: doc['year'],
                  );
                  this._casesList.add(_case);
                }
              });
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) =>
                      CaseCard(_casesList[index]),
                  itemCount: _casesList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 10,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
