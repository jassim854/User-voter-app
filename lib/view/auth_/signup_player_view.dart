import 'dart:io';

import 'package:flutter/material.dart';


import 'package:intl/intl.dart';
import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/utilis/app_typography.dart';
import 'package:voter_app/utilis/validators.dart';
import 'package:voter_app/widget/app_bar_widget.dart';
import 'package:voter_app/widget/circle_imagw_widget.dart';
import 'package:voter_app/widget/custom_button_widget.dart';
import 'package:voter_app/widget/custom_radio_button.dart';


import '../../controller/auth_controller.dart';
import '../../helper/basehelper.dart';
import '../../widget/textfield_widget.dart';

class SignupPlayerView extends StatefulWidget {
  const SignupPlayerView({super.key});

  @override
  State<SignupPlayerView> createState() => _SignupPlayerViewState();
}

class _SignupPlayerViewState extends State<SignupPlayerView> {
  bool updated = false;
  bool privacyCheck = false;
  DateTime initialDate = DateTime.now();
  String? imageUrl;
  String? genderRadio;
  bool obsecureVar = false;
  String rankingRadio = "Si";
  String federationRank = '';
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController dobController;

  late TextEditingController cityController;
  late TextEditingController federationLinkController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    dobController = TextEditingController();

    cityController = TextEditingController();
    federationLinkController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    cityController.dispose();
    federationLinkController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        BaseHelper.hideKeypad(context);
        bool? shouldPop;
        // if (updated == true) {
        //   shouldPop = await showDialog(
        //       context: context,
        //       builder: (context) => customDialogBox(context, onCancel: () {
        //             Navigator.of(context).pop(false);
        //           }, onOk: () {
        //             Navigator.of(context).pop(true);
        //           }));
        // } else {
        //   shouldPop = true;
        // }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBarWidget(
          background: Colors.transparent,
          title:"Sign Up"
             
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomCircleAvatar(
                        radius: 60,
                        images: "ImagePath.loginlogo,",
                        
                        imageUrl: imageUrl,
                      ),
                      Positioned(
                        top: 80,
                        left: 85,
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () async {
                                BaseHelper.hideKeypad(context);
                                String? downloadableLink;
                                File? imageVar =
                                    await BaseHelper.imagePickerSheet(context);

                                if (imageVar != null) {
                                  await Auth.uploadImage(
                                    imageVar,
                                    context,
                                  ).then((value) => downloadableLink = value);
                                }
                                setState(() {
                                  imageUrl = downloadableLink;
                                  updated = true;
                                });
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 18,
                              )),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 10),
                    child: TextFields(
                      text:"Enter first and last name",
                      controller: nameController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateField(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text:"Enter Email",
                      controller: emailController,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validateEmail(p0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      text:"Enter Password",
                      controller: passwordController,
                      obsecureText: obsecureVar,
                      onChanged: (va) {
                        if (va.toString().isNotEmpty) {
                          updated = true;
                        } else {
                          updated = false;
                        }
                      },
                      validator: (p0) => Validators.validatePassword(p0),
                      suffixicon: IconButton(
                        onPressed: () {
                          setState(() {
                            obsecureVar = !obsecureVar;
                          });
                        },
                        icon: Icon(
                            obsecureVar
                                ? Icons.visibility_off_rounded
                                : Icons.remove_red_eye,
                            size: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFields(
                      controller: dobController,
                      text: "Select DOB",
                      readOnly: true,
                    
                      onTap: () async {
                        final date = await BaseHelper.datePicker(context,
                            initialDate: initialDate);
                        if (date == null) return;
                        dobController.text =
                            DateFormat('MMM dd ,yyyy').format(date);
                        updated = true;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //   child: TextFields(
                  //     readOnly: true,
                  //     text:"Select city" ,
                  //     controller: cityController,
                  //     onTap: () async {
                  //       await GooglePlaces.googlePlaccesLoc(context)
                  //           .then((value) {
                  //         if (value != "null") {
                  //           cityController.text = value.toString();
                  //           updated = true;
                  //           return;
                  //         }
                  //         updated = false;
                  //       });
                  //     },
                  //     validator: (p0) => Validators.validateField(p0),
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select gender", style: text_color),
                      Row(
                        children: [
                          CustomRadioButton(
                              val: genderRadio.toString(),
                              value: 'M',
                              text: 'M',
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  genderRadio = value!;
                                });
                              }),
                          CustomRadioButton(
                              val: genderRadio.toString(),
                              value: 'F',
                              text: 'F',
                              onChanged: (value) {
                                updated = true;
                                setState(() {
                                  genderRadio = value!;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                
               
                  const SizedBox(
                    height: 53,
                  ),
                  CustomButton(
                      color: AppColor.divivdercolor,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: "Sign Up",
                      style: subTitle16DarkGreyStyle.copyWith(fontSize: 22),
                      onpressed: () {
                        if (formKey.currentState!.validate()) {
                          Auth.signUp(context,
                              city: cityController.text,
                              dob: dobController.text,
                              email: emailController.text.toLowerCase().trim(),
                           
                              genderRadio: genderRadio.toString(),
                              imageUrl: imageUrl.toString(),
                              name: nameController.text,
                              password: passwordController.text.trim(),
                            
                              );
                        } else {
                          return;
                        }
                      }),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
