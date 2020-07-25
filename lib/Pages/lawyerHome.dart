import 'package:Lawyer/Models/case.dart';
import 'package:Lawyer/Models/user.dart';
import 'package:Lawyer/Pages/SideDrawer/myCases.dart';
import 'package:Lawyer/Pages/lawyerLogin.dart';
import 'package:Lawyer/Services/lawyerAuth.dart';
import 'package:Lawyer/Widgets/caseCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'SideDrawer/profile.dart';

class LawyerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LawyerHomePageState();
  }
}

class LawyerHomePageState extends State<LawyerHomePage> {
  List<Case> _casesList = [];
  List<User> _users = [];
  LawyerAuthService _lawyerAuthService = LawyerAuthService();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    _users = [];
    loading = true;
    Firestore.instance.collection('user').getDocuments().then((doc) {
      doc.documents.forEach((value) {
        User user = new User(
          uid: value.documentID,
          email: value.data['email'],
          firstName: value.data['firstName'],
          lastName: value.data['lastName'],
          phoneNumber: value.data['phoneNumber'],
        );
        _users.add(user);
      });
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // UserDataService _userDataService =
    //     UserDataService(Provider.of<Lawyer>(context).uid);
    // this._lawyersList = _userDataService.getLawyers();
    return Scaffold(
      backgroundColor: Colors.brown[100],
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(
                Icons.work,
              ),
              title: Text('My cases'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCasesPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
              ),
              title: Text('Requests'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LawyerHomePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
              ),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text('Log out'),
              onTap: () async {
                await _lawyerAuthService.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LawyerLoginPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Title(
          color: Colors.white,
          child: Text("Lawyerito - Lawyer"),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('case')
              .where('assigned', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            if ((!snapshot.hasData) || loading) {
              return SpinKitChasingDots(
                color: Colors.brown[400],
              );
            } else {
              this._casesList = [];
              snapshot.data.documents.forEach((doc) {
                print(doc['assigned']);

                User _user;
                _users.forEach((element) {
                  if (element.uid == doc['owner']) {
                    _user = element;
                  }
                });
                Case _case = new Case(
                  assigned: doc['assigned'],
                  assignedLawyer: doc['assignedLawyer'],
                  caseNumber: doc['caseNumber'],
                  caseType: doc['caseType'],
                  information: doc['information'],
                  owner: _user,
                  state: doc['state'],
                  year: doc['year'],
                );
                this._casesList.add(_case);
              });
              print(_casesList.length);
            }

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
          }),
    );
  }
}
