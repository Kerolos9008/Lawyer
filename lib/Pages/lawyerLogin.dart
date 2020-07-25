import 'package:Lawyer/Pages/lawyerHome.dart';

import '../Services/lawyerAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'lawyerRegister.dart';

class LawyerLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LawyerLoginPageState();
  }
}

class LawyerLoginPageState extends State<LawyerLoginPage> {
  final LawyerAuthService _auth = LawyerAuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Login'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LawyerRegisterPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "password",
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2.0),
                  ),
                ),
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: loading
                      ? SpinKitChasingDots(
                          color: Colors.brown,
                          size: 14.0,
                        )
                      : Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      loading = true;
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      loading = false;
                      if (result == null) {
                        setState(() {
                          error = 'Wrong email or password';
                        });
                      } else {
                        error = '';
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LawyerHomePage()));
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
