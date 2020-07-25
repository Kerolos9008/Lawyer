import 'package:Lawyer/Models/lawyer.dart';
import 'package:Lawyer/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  User userData;
  bool updateProfile = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text("My Profile"),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SpinKitChasingDots(
                  color: Colors.brown[400],
                );
              } else {
                snapshot.data.documents.forEach((element) {
                  if (element.documentID == Provider.of<Lawyer>(context).lawyerId) {
                    userData = User(
                      uid: Provider.of<Lawyer>(context).lawyerId,
                      email: element.data['email'],
                      firstName: element.data['firstName'],
                      lastName: element.data['lastName'],
                      phoneNumber: element.data['phoneNumber'],
                    );
                  }
                });
                return Container(child: Text("Profile working."),);
              }
              
            }),
      ),
    );
  }
}
