import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/pendingRequest.dart';

class RequestDetails extends StatefulWidget {
  //variale that will store phoneNumber of user passed from another screen
  String phoneNumber = '';

  //constructor used to initilize the phoneNumber variable
  RequestDetails(String value) {
    this.phoneNumber = value;
  }

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  //list that will fetcg details of particular user
  List userDetails = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: FutureBuilder(
            future: fetchUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, 0.0, w * 0.02, h * 0.03),
                        child: Text(
                            'Name - ${userDetails[0] + ' ' + userDetails[1] + ' ' + userDetails[2]}',
                            style: TextStyle(fontSize: h * 0.025)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, 0.0, w * 0.02, h * 0.03),
                        child: Text('Roll Number - ${userDetails[3]}',
                            style: TextStyle(fontSize: h * 0.025)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, 0.0, w * 0.02, h * 0.03),
                        child: Text('Phone Number - ${userDetails[4]}',
                            style: TextStyle(fontSize: h * 0.025)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, 0.0, w * 0.02, h * 0.03),
                        child: Text('Email ID - ${userDetails[5]}',
                            style: TextStyle(fontSize: h * 0.025)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            w * 0.02, 0.0, w * 0.02, h * 0.03),
                        child: Text('Date of Birth - ${userDetails[6]}',
                            style: TextStyle(fontSize: h * 0.025)),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                child: ElevatedButton(
                                    onPressed: (() {
                                      createUser(
                                          userDetails[0],
                                          userDetails[1],
                                          userDetails[2],
                                          userDetails[3],
                                          userDetails[4],
                                          userDetails[5],
                                          userDetails[6],
                                          userDetails[7],
                                          userDetails[8]);
                                      removeVerifiedUser(userDetails[4]);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PendingRequest()));
                                    }),
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 62, 124, 217)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors
                                                        .blue.shade900)))),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            w * 0.05, h * 0.005, w * 0.05, h * 0.005),
                                        child: Text('Accept', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50))))),
                            Container(
                                child: ElevatedButton(
                                    onPressed: (() {
                                      removeVerifiedUser(userDetails[4]);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PendingRequest()));
                                    }),
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all(15),
                                        backgroundColor: MaterialStateProperty.all(
                                            Color.fromARGB(255, 62, 124, 217)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors
                                                        .blue.shade900)))),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            w * 0.05, h * 0.005, w * 0.05, h * 0.005),
                                        child: Text('Reject', style: TextStyle(fontFamily: 'comic', fontSize: w * 0.08, color: Colors.blue.shade50)))))
                          ])
                    ]);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Future<List> fetchUserDetails() async {
    var phonenumber = widget.phoneNumber;
    var userDetailsRef = await FirebaseFirestore.instance
        .collection('VerifyUserInformation')
        .doc(phonenumber)
        .get();

    userDetails.add(userDetailsRef['FirstName']);
    userDetails.add(userDetailsRef['MiddleName']);
    userDetails.add(userDetailsRef['LastName']);
    userDetails.add(userDetailsRef['RollNumber']);
    userDetails.add(userDetailsRef['PhoneNumber']);
    userDetails.add(userDetailsRef['OrganizationEmailID']);
    userDetails.add(userDetailsRef['DateOfBirth']);
    userDetails.add(userDetailsRef['EmergencyContactNumber']);
    userDetails.add(userDetailsRef['Password']);
    return userDetails;
  }

  void createUser(
      String firstName,
      String middleName,
      String lastName,
      String rollNumber,
      String phoneNumber,
      String organizationEmailID,
      String dateOfBirth,
      String emergencyContactNumber,
      String password) async {
    var userInformationRef = await FirebaseFirestore.instance
        .collection('UserInformation')
        .doc(phoneNumber)
        .set({
      'PhoneNumber': phoneNumber,
      'FirstName': firstName,
      'LastName': lastName,
      'MiddleName': middleName,
      'EmergencyContactNumber': emergencyContactNumber,
      'OrganizationEmailID': organizationEmailID,
      'DateOfBirth': dateOfBirth,
      'RollNumber': rollNumber,
      'Password': password
    });
  }

  void removeVerifiedUser(String phoneNumber) async {
    var verifyUserInformationRef = await FirebaseFirestore.instance
        .collection('VerifyUserInformation')
        .doc(phoneNumber)
        .delete();
  }
}
