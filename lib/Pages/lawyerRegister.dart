import 'dart:convert';
import 'dart:io';

import 'package:Lawyer/Pages/lawyerHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../Services/lawyerAuth.dart';

class LawyerRegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LawyerRegisterPageState();
  }
}

class LawyerRegisterPageState extends State<LawyerRegisterPage> {
  final LawyerAuthService _auth = LawyerAuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  File file;

  // text field state
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
  String image = '';
  String officeAddress = '';
  String nationalId = '';
  String since = '';

  Widget _showImage() {
    if (file == null) {
      return Image.asset(
        'assets/images/profile-placeholder.png',
        width: 80.0,
        height: 80.0,
      );
    } else {
      return Image.file(
        file,
        width: 80.0,
        height: 80.0,
      );
    }
  }

  Future _chooseImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    final File newImage = File(pickedFile.path);

    setState(() {
      file = newImage;
    });
    List<int> imageBytes = file.readAsBytesSync();
    image = base64Encode(imageBytes);
  }

  Widget _buildPictureUploadField() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            _showImage(),
          ],
        ),
        SizedBox(
          width: 30.0,
        ),
        RaisedButton(
          child: Text('Choose Image'),
          onPressed: _chooseImage,
        )
      ],
    );
  }

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
            elevation: 0.0,
            title: Text('Register'),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(color: Colors.pink),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.all(12.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.pink, width: 2.0),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (String value) {
                                  if (value.isEmpty ||
                                      !RegExp(r"^[A-Za-z]*$").hasMatch(value)) {
                                    return 'Please enter your first name (all letters)';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  firstName = value;
                                },
                                onChanged: (val) {
                                  setState(() => firstName = val);
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(color: Colors.pink),
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.pink, width: 2.0),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                validator: (String value) {
                                  if (value.isEmpty ||
                                      !RegExp(r"^[A-Za-z]*$").hasMatch(value)) {
                                    return 'Please enter your last name (all letters)';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() => lastName = val);
                                },
                                onSaved: (String value) {
                                  lastName = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(color: Colors.pink),
                          hintText: "01000000000",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => (val.isEmpty ||
                                !RegExp(r"^01[0,1,2,5][0-9]{8}$").hasMatch(val))
                            ? 'Enter a valid mobile number'
                            : null,
                        onChanged: (val) {
                          setState(() => phoneNumber = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "National ID",
                          labelStyle: TextStyle(color: Colors.pink),
                          hintText: "29812032300511",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => (val.isEmpty ||
                                !RegExp(r"^[2-3][0-9]{13}$").hasMatch(val))
                            ? 'Enter a valid nationa ID.'
                            : null,
                        onChanged: (val) {
                          setState(() => nationalId = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Lawyer Since",
                          labelStyle: TextStyle(color: Colors.pink),
                          hintText: "2012",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => (val.isEmpty ||
                                !RegExp(r"^[1-2][0-9]{3}$").hasMatch(val) ||
                                (int.parse(val) > 2020) ||
                                (int.parse(val) < 1950))
                            ? 'Enter a valid year.'
                            : null,
                        onChanged: (val) {
                          setState(() => since = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Office Address",
                          labelStyle: TextStyle(color: Colors.pink),
                          hintText: "40, School St., Omraneya, Gize",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) =>
                            (val.isEmpty) ? 'Enter your address' : null,
                        onChanged: (val) {
                          setState(() => officeAddress = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.pink),
                          hintText: "name@example.com",
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => (val.isEmpty ||
                                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val))
                            ? 'Enter an email'
                            : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.pink),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => val.length < 8
                            ? 'Enter a password 8+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.pink),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (val) => (val != password)
                            ? "Doesn't match the password"
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      _buildPictureUploadField(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 35,
                        width: 90,
                        child: RaisedButton(
                          color: Colors.pink[400],
                          child: loading
                              ? SpinKitChasingDots(
                                  color: Colors.white,
                                  size: 14.0,
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                email,
                                password,
                                firstName,
                                lastName,
                                phoneNumber,
                                officeAddress,
                                image,
                                nationalId,
                                since,
                              );
                              setState(() {
                                loading = false;
                              });
                              if (result == null) {
                                setState(() {
                                  error = 'this email already exists';
                                });
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LawyerHomePage()));
                                error = '';
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
