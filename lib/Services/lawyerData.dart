import 'package:Lawyer/Models/lawyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/user.dart';

class LawyerDataService {
  final String uid;
  LawyerDataService(this.uid) {
    print("UserDataService user = " + this.uid);
  }

  final CollectionReference userCollection =
      Firestore.instance.collection('user');
  final CollectionReference lawyerCollection =
      Firestore.instance.collection('lawyer');
  final CollectionReference caseCollection =
      Firestore.instance.collection('case');
  final CollectionReference requestCollection =
      Firestore.instance.collection('caseRequest');

  Future<void> updateLawyerData(
    String email,
    String firstName,
    String lastName,
    String phoneNumber,
    String officeAddress,
    String image,
    String nationalId,
    String since,
  ) async {
    return await lawyerCollection.document(uid).setData({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'officeAddress': officeAddress,
      'image': image,
      'nationalId': nationalId,
      'since': since,
    });
  }

  Future<DocumentReference> createCase(String caseNumber, String year,
      String caseType, String information, User owner) async {
    return await caseCollection.add({
      'caseNumber': caseNumber,
      'year': year,
      'caseType': caseType,
      'information': information,
      'owner': owner.uid,
      'assigned': false,
      'state': "in Progress",
    });
  }

  List<Lawyer> getLawyers() {
    List<Lawyer> lawyers = [];
    lawyerCollection.snapshots().listen((data) {
      data.documents.forEach((doc) {
        Lawyer lawyer = new Lawyer(
          email: doc['email'],
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          image: doc['image'],
          officeAddress: doc['officeAddress'],
          phoneNumber: doc['phoneNumber'],
        );
        print("lawyer:" + lawyer.toString());
        lawyers.add(lawyer);
      });
    });
    print("length = " + lawyers.length.toString());
    return lawyers;
  }

  Future<User> getUserData() async {
    User userData;
    final CollectionReference userCollection =
        Firestore.instance.collection('user');
    await userCollection.document(this.uid).get().then((element) {
      userData = User(
        uid: this.uid,
        email: element.data['email'],
        firstName: element.data['firstName'],
        lastName: element.data['lastName'],
        phoneNumber: element.data['phoneNumber'],
      );
    });
    return userData;
  }
}
