import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:voter_app/model/user_model.dart';
import 'package:voter_app/utilis/app_colors.dart';







class BaseHelper {
  static showSnackBar(context, msg, {button}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: AppColor.maincolor,
      margin: const EdgeInsets.all(5),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // static double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }

  static hideKeypad(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


  static FirebaseAuth auth = FirebaseAuth.instance;

  static User? currentUser = auth.currentUser;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static UserModel? user;

  static Future<DateTime?> datePicker(
    context, {
    required DateTime initialDate,
  }) async {
    return await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
  }

  static Future<File?> imagePickerSheet(context) {
    late var imageVar;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context, ImageSource.camera);
                    },
                    horizontalTitleGap: 0,
                    title: const Text('Camera', style: TextStyle(fontSize: 18)),
                    leading:
                        const Icon(Icons.camera_alt, color: AppColor.maincolor),
                  ),
                  ListTile(
                    horizontalTitleGap: 0,
                    onTap: () {
                      Navigator.pop(context, ImageSource.gallery);
                    },
                    title: const Text("Gallery",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    leading: const Icon(Icons.image, color: AppColor.maincolor),
                  ),
                ],
              ),
            ),
          );
        },
        elevation: 20.0,
        useRootNavigator: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ))).then((value) {
      if (value != null) {
        return imageVar = onCameraTap(context, value);
      } else {
        return imageVar = value;
      }
    });
  }

  static Future<File?> onCameraTap(context, ImageSource source) {
    return ImagePicker.platform
        .getImageFromSource(source: source)
        .then((value) {
      if (value != null) {
        File imageVar = File(value.path);
        return imageVar;
      } else {
        BaseHelper.showSnackBar(context, 'Please Select any file');
      }
    });
  }
}
