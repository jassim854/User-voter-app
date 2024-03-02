import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';



import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';


import 'package:google_sign_in/google_sign_in.dart';


import 'package:uuid/uuid.dart';
import 'package:voter_app/helper/basehelper.dart';

import 'package:voter_app/model/user_model.dart';
import 'package:voter_app/view/home_view.dart';

import '../Firebase/firebase_methods.dart';
import 'package:http/http.dart' as http;





import 'package:intl/intl.dart';






class Auth {

  static TextEditingController phoneNumberController = TextEditingController();
  static Future<String?> uploadImage(
    File imageVar,
    context,
  ) async {
    EasyLoading.show();
    String? downloadableLink;
    String uniqueFilename = const Uuid().v1();

    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceRootDir = reference.child('images');
    Reference referenceRootDirToUpload = referenceRootDir.child(uniqueFilename);
    try {
      await referenceRootDirToUpload.putFile(File(imageVar.path));
      await referenceRootDirToUpload.getDownloadURL().then((value) {
        return downloadableLink = value;
      });
    } catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, 'Some thing Went Wrong');
      return downloadableLink = '';
    }
    EasyLoading.dismiss();
    return downloadableLink;
  }

  static Future signUp(context,
      {
      required String dob,

      required String genderRadio,
    
      required String city,
      required String email,
      required String password,
      required String name,
      required String imageUrl,
    }) async {
    if (imageUrl == "null") {
      BaseHelper.showSnackBar(context, "Please select your Profile Photo");
      return;
    }  else if (genderRadio == '') {
      BaseHelper.showSnackBar(context, "Please select sesso");
      return;
    } 

    BaseHelper.hideKeypad(context);
    EasyLoading.show();

    try {
      User? user = (await BaseHelper.auth.createUserWithEmailAndPassword(
              email: email.trim().toLowerCase(), password: password.trim()))
          .user;
      if (user != null) {
        print("created");
        await BaseHelper.auth.currentUser?.updateDisplayName(name);
        await BaseHelper.auth.currentUser?.updatePhotoURL(imageUrl.toString());

        var data = {
       
      "name": name,
      "email": email,
      "password": password,
 
      // "address": address,

      "dob": dob,
      "city": city,
      "gender": genderRadio,



      "profilePhoto": imageUrl,
"becomeCandidate":false

  
           };
        await FirebaseMethod.setUserData(data);

        EasyLoading.dismiss();

        await FirebaseMethod.getUserData();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );
        return user;
      } else {
        print('no data store');
      }
    } on FirebaseAuthException catch (e) {
      BaseHelper.showSnackBar(context, e.message);
    }
    EasyLoading.dismiss();
    return;
  }


  static logInAuth(context,
      {required String email, required String password}) async {
    BaseHelper.hideKeypad(context);
    EasyLoading.show();
    try {
      await BaseHelper.auth.signInWithEmailAndPassword(
          email: email.trim()..toLowerCase(), password: password.trim());

      EasyLoading.dismiss();

      await FirebaseMethod.getUserData();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
      return;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
    }

    EasyLoading.dismiss();
    return;
  }

 
  static signInGoogle(context) async {
    User? user;
    BaseHelper.hideKeypad(context);
    EasyLoading.show();

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.profile",
      'https://www.googleapis.com/auth/user.birthday.read',
      "https://www.googleapis.com/auth/user.gender.read",
      "https://www.googleapis.com/auth/user.addresses.read"
    ];
    GoogleSignInAccount? googleSignInAccount;
    try {
      final GoogleSignIn googleUser = GoogleSignIn(
        scopes: scopes,
      );
      googleSignInAccount = await googleUser.signIn();
    } catch (e) {
      BaseHelper.showSnackBar(context, e.toString());
      EasyLoading.dismiss();
      return;
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await BaseHelper.auth.signInWithCredential(credential);
        user = userCredential.user;
        await FirebaseMethod.getUserData();
        if (BaseHelper.user == null) {
          var userData = {

       
              "name": user?.displayName.toString() ?? "",
              "email": user?.email.toString() ?? "",
    
              "profilePhoto": user?.photoURL.toString() ?? "",
      
       
       
      
 
 
     




              
              };

          final http.Response response = await http.get(
            Uri.parse('https://people.googleapis.com/v1/people/me'
                '?personFields=locations,birthdays,genders,addresses,sipAddresses'),
            headers: await googleSignInAccount.authHeaders,
          );

          if (response.statusCode == 200) {
            final Map data = jsonDecode(response.body);
            if (data.containsKey("genders") || data.containsKey("birthdays")) {
              await FirebaseMethod.setUserData(userData);

              final List birth = data['birthdays'];

              Map<dynamic, dynamic> birthdays = {};
              if (birth.length > 1) {
                birthdays = birth[1]["date"];
              } else {
                birthdays = birth[0]["date"];
              }

              if (birthdays.isNotEmpty) {
                DateTime date = DateFormat("yyyy MM dd").parse(
                    "${birthdays['year']} ${birthdays['month']} ${birthdays['day']}}");

                int days = DateTime.now().difference(date).inDays;
                if (days < 6570) {
                  EasyLoading.dismiss();
                  BaseHelper.showSnackBar(
                      context, 'your age is less than 18 years');
                  BaseHelper.auth.currentUser?.delete();
                  GoogleSignIn().signOut();
                  return null;
                }
                FirebaseMethod.updateData(
                    {"dob": DateFormat('MMM,dd,yyyy').format(date)});
              } else {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(context, "failed to retrieve dob");
                return null;
              }

              final gender = data['genders'][0]["formattedValue"];
              if (gender != null) {
                FirebaseMethod.updateData({
                  "gender": gender == "Male"
                      ? 'M'
                      : gender == "Female"
                          ? "F"
                          : ''
                });
              } else {
                EasyLoading.dismiss();
                BaseHelper.showSnackBar(context, "failed to retrieve gender");
                return null;
              }
            } else {
              EasyLoading.dismiss();
              BaseHelper.showSnackBar(context,
                  "Your Selected email: ${BaseHelper.auth.currentUser?.email} does not have gender and dob details");

              BaseHelper.auth.currentUser?.delete();
              GoogleSignIn().signOut();
              return null;
            }
          } else {
            EasyLoading.dismiss();

            BaseHelper.showSnackBar(
                context, "Something went wrong geting data from google");
            BaseHelper.auth.currentUser?.delete();
            GoogleSignIn().signOut();

            return null;
          }

          await FirebaseMethod.getUserData();
        }

        EasyLoading.dismiss();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
          (route) => false,
        );

        return user;
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        BaseHelper.showSnackBar(context, e.message);
        GoogleSignIn().signOut();
      }
    } else {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, "Select account for login");
      return null;
    }

    EasyLoading.dismiss();
    return null;
  }





  static logOut(context) async {
    EasyLoading.show();

    if (BaseHelper.currentUser?.providerData.first.providerId.toString() ==
        'google.com') {
      await GoogleSignIn().signOut();
    } 

    await FirebaseAuth.instance.signOut();

    BaseHelper.user = null;
    BaseHelper.currentUser = BaseHelper.auth.currentUser;
    EasyLoading.dismiss();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeView()),
      (route) => false,
    );
  }

  static Future forgetPassword(context, {required String email}) async {
    BaseHelper.hideKeypad(context);
    EasyLoading.show();
    try {
      await BaseHelper.auth.sendPasswordResetEmail(
        email: email.trim()..toLowerCase(),
      );
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      BaseHelper.showSnackBar(context, e.message);
      return;
    }
    EasyLoading.dismiss();
    BaseHelper.showSnackBar(context,
        'Password Reset Email Sent Has been sent to ${email.trim().toLowerCase()}');

    return;
  }
}
