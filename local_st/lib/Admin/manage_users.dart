import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:local_st/Data-Services/utilities.dart';

class ManageUsers {
  //Objects to access method from other class Files
  Utilities utilities = Utilities();

  //Insert Data to VerifiyUserInformation to get it verify from admin
  Future<void> verificationOfUserInformation(
      String phoneNumber,
      String password,
      String firstName,
      String middleName,
      String lastName,
      String dateOfBirth,
      String emergencyContactNo,
      String organizationEmailID,
      String rollNumber,
      String role) async {
    await FirebaseFirestore.instance
        .collection('VerifyUserInformation')
        .doc(utilities.add91(phoneNumber))
        .set({
      'PhoneNumber': utilities.add91(phoneNumber),
      'Password': encrypt(password),
      'FirstName': firstName,
      'MiddleName': middleName,
      'LastName': lastName,
      'DateOfBirth': dateOfBirth,
      'EmergencyContactNumber': utilities.add91(emergencyContactNo),
      'OrganizationEmailID': organizationEmailID,
      'OrganizationName': 'Pandit Deendayal Energy University',
      'RollNumber': rollNumber,
      'Role': role
    });
    return;
  }

  static encrypt(String data) {
    final key = Key.fromUtf8('[!(%%FQ6cd7[FZZ0');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(data, iv: iv).base64;
  }

  static decrypt(String data) {
    final key = Key.fromUtf8('[!(%%FQ6cd7[FZZ0');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(data, iv: iv);
  }
}
