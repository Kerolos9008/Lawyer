import 'package:Lawyer/Models/case.dart';
import 'package:Lawyer/Pages/feedbackPage.dart';
import 'package:flutter/material.dart';

import 'lawyerPage.dart';
import 'userPage.dart';

class CasePage extends StatefulWidget {
  final Case _case;

  CasePage(this._case);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CasePageState();
  }
}

class CasePageState extends State<CasePage> {
  Color stateColor;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (this.widget._case.state.compareTo("in Progress") == 0) {
      stateColor = Colors.black38;
    } else if (this.widget._case.state.compareTo("Won") == 0) {
      stateColor = Colors.green;
    } else {
      stateColor = Colors.red;
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Case ' +
              this.widget._case.caseNumber +
              ' for year ' +
              this.widget._case.year),
        ),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Case of ' + this.widget._case.caseType,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Owned by ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserPage()));
                      },
                      child: Text(
                        this.widget._case.owner.firstName +
                            ' ' +
                            this.widget._case.owner.lastName,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                this.widget._case.assigned
                    ? Row(
                        children: <Widget>[
                          Text(
                            'Assigned to ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LawyerPage()));
                            },
                            child: Text(
                              this.widget._case.assignedLawyer.firstName +
                                  ' ' +
                                  this.widget._case.assignedLawyer.lastName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Not Assigned yet',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 5,
                  ),
                  child: Text(
                    this.widget._case.information,
                    // textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    this.widget._case.state,
                    style: TextStyle(fontSize: 14, color: stateColor),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.pink,
                        child: Text(
                          'Give Feedback',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FeedbackPage()));
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Colors.pink,
                        child: Text(
                          'Request Case',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
