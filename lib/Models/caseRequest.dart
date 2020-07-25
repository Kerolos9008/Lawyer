import 'package:Lawyer/Models/case.dart';
import 'package:Lawyer/Models/lawyer.dart';

class CaseRequest{

  final Lawyer lawyer;
  final Case requestedCase;
  bool accepted;
  final String feedback;

  CaseRequest({this.lawyer, this.requestedCase, this.accepted, this.feedback});

}