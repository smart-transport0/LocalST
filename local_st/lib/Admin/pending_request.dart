import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_st/Admin/request_details.dart';
import 'package:local_st/Reusable/Admin/bottom_navigation_bar.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({Key? key}) : super(key: key);

  @override
  State<PendingRequest> createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  //List that will fetch user request which will then verify by admin
  List pendingRequests = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Smart Transportation',
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavBar(2),
        body: Padding(
          padding: EdgeInsets.fromLTRB(0.0, h * 0.06, 0.0, h * 0.06),
          child: SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                    future: fetchRequest(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: pendingRequests.length,
                          itemBuilder: (context, index) => Column(children: <Widget>[
                            SizedBox(
                              width: w * 0.85,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)),
                                  color: (index % 2 == 0)
                                      ? Colors.white60
                                      : Colors.black12,
                                  child: ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0.0, h * 0.02, 0.0, h * 0.02),
                                      child: Column(children: <Widget>[
                                        Text(
                                            'Name: ' '${pendingRequests[index][0] + ' ' + pendingRequests[index][1] + ' ' + pendingRequests[index][2]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blue.shade900)),
                                        SizedBox(height: h * 0.01),
                                        Text(
                                            'Phone Number: ' '${pendingRequests[index][3]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blue.shade900)),
                                        SizedBox(height: h * 0.01),
                                        Text(
                                            'Email ID: ' '${pendingRequests[index][4]}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blue.shade900)),
                                      ]),
                                    ),
                                    onTap: () {
                                      String value =
                                          pendingRequests[index][3];
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RequestDetails(phoneNumber: value)));
                                    },
                                  )),
                            )
                          ]),
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        ));
  }

  Future<List> fetchRequest() async {
    var verifyUserInformationRef = await FirebaseFirestore.instance
        .collection('VerifyUserInformation')
        .get();
    setState(() {
      pendingRequests = [];
      for (var fetchedData in verifyUserInformationRef.docs) {
        pendingRequests.add([
          fetchedData['FirstName'],
          fetchedData['MiddleName'],
          fetchedData['LastName'],
          fetchedData['PhoneNumber'],
          fetchedData['OrganizationEmailID']
        ]);
      }
    });
    return pendingRequests;
  }
}
