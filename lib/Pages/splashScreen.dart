import 'package:Lawyer/Models/lawyer.dart';
import 'package:Lawyer/Pages/lawyerHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/user.dart';
import 'lawyerLogin.dart';

class SplashScreenPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
  
}

class SplashScreenState extends State<SplashScreenPage>{
  Lawyer lawyer;

  @override
  Widget build(BuildContext context) {
    lawyer = Provider.of<Lawyer>(context);
    new Future.delayed(const Duration(milliseconds: 2000), checkAuth);
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.brown[50],
      child: Container(
        child: Image.asset('assets/images/Logo.png'),
        width: MediaQuery.of(context).size.width * 3 / 4,
        height: MediaQuery.of(context).size.width * 3 / 4,
      ),
    );
  }

  void checkAuth(){
    print("user in chechAuth = " + lawyer.toString());
    if (lawyer == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LawyerLoginPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LawyerHomePage()));
    }
  }
}