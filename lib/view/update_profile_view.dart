// import 'dart:io';

// import 'package:flutter/foundation.dart';

// import 'package:flutter/material.dart';
// import 'package:voter_app/firebase/firebase_methods.dart';
// import 'package:voter_app/widget/custom_button_widget.dart';



// import '../../../controller/auth_controller.dart';


// import '../../../helper/basehelper.dart';


// class AccountSettingView extends StatefulWidget {
//   const AccountSettingView({super.key, required this.willPopValue});
//   final bool willPopValue;

//   @override
//   State<AccountSettingView> createState() => _AccountSettingViewState();
// }

// class _AccountSettingViewState extends State<AccountSettingView> {
//   late TextEditingController federationLinkAccountController;

//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   late TextEditingController passwordController;
//   late TextEditingController dobController;
//   late TextEditingController cityController;
//   late TextEditingController addressController;
// String name='';
//   @override
//   void initState() {
//     if (widget.willPopValue == false) {
//       getLoc();
//     }
//     values();
//     federationLinkAccountController = TextEditingController();
//     nameController = TextEditingController();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//     dobController = TextEditingController();
//     cityController = TextEditingController();
//     addressController = TextEditingController();

//     // TODO: implement initState
//     super.initState();
//   }

//   Future<bool?> getLoc() async {
//     await LocPermission.handleLocationPermission(context).then((value) {
//       if (value == true) {
//         Geolocator.getCurrentPosition().then((event) async {
//           await HomePageController.getAddressFromLatLng(context, event)
//               .then((value) {
//             if (value == true) {
//               cityController.text = BaseHelper.user?.city ?? "";
//               setState(() {});
//             }
//           });
//         });
//       }
//     });
//     return null;
//   }

//   @override
//   void dispose() {
//     federationLinkAccountController.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     dobController.dispose();
//     cityController.dispose();

//     addressController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   values() async {
//     if (widget.willPopValue == true) {
//       await FirebaseMethod.getUserData();
//     }

  
    


//     AccountSettingController.campiItemAdded
//         .addAll(BaseHelper.user?.campi?.toList() ?? []);
//     AccountSettingController.gender = BaseHelper.user?.gender ?? '';
//     nameController.text = BaseHelper.user?.name ?? "";
//     emailController.text = BaseHelper.currentUser?.email ?? "";
//     passwordController.text = BaseHelper.user?.password ?? "";
//     dobController.text = BaseHelper.user?.dob ?? "";
//     cityController.text = BaseHelper.user?.city ?? "";
//     addressController.text = BaseHelper.user?.address ?? "";



//     return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () async {
//         BaseHelper.hideKeypad(context);

//         if (widget.willPopValue == true &&
//             AccountSettingController.isEdit == true) {
//           var shouldPop = await showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder: (context) => customDialogBox(context,
//                       title: context.loc.yourChangesWillBeLost, onCancel: () {
//                     Navigator.of(context).pop(false);
//                   }, onOk: () {
//                     AccountSettingController.isEdit = false;

//                     Navigator.of(context).pop(true);
//                   }));
//           return Future.value(shouldPop);
//         } else {
//           return Future.value(widget.willPopValue);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBarWidget(
//           title: 'II mio account',
//         ),
//         body: ListView(
//           shrinkWrap: true,
//           padding:
//               const EdgeInsets.only(bottom: 30, left: 30, right: 30, top: 20),
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                     onTap: () {
//                       AccountSettingController.isEdit = true;

//                       setState(() {});
//                       AccountSettingController.isEdit == true
//                           ? BaseHelper.showSnackBar(
//                               context, 'You can now edit  ')
//                           : null;
//                     },
//                     child: Text(
//                       AccountSettingController.isEdit == false ? "Edit" : '',
//                       style: subTitle16BlackStyle,
//                     ))
//               ],
//             ),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 CustomCircleAvatar(
//                     radius: 60,
//                     imageUrl: AccountSettingController.imageFile == ''
//                         ? BaseHelper.currentUser?.photoURL.toString()
//                         : AccountSettingController.imageFile),
//                 if (AccountSettingController.isEdit == true)
//                   Positioned(
//                     right: width * 0.27,
//                     top: 80,
//                     child: Align(
//                       alignment: Alignment.bottomRight,
//                       child: Container(
//                         width: 35,
//                         decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.3),
//                             shape: BoxShape.circle),
//                         child: IconButton(
//                             onPressed: () async {
//                               String? downloadableLink;
//                               File? imageVar =
//                                   await BaseHelper.imagePickerSheet(context);

//                               if (imageVar != null) {
//                                 await Auth.uploadImage(
//                                   imageVar,
//                                   context,
//                                 ).then((value) {
//                                   downloadableLink = value;
//                                   setState(() {
//                                     AccountSettingController.imageFile =
//                                         downloadableLink.toString();
//                                   });
//                                 });
//                               }
//                             },
//                             icon: const Icon(
//                               Icons.camera_alt,
//                               color: Colors.grey,
//                               size: 18,
//                             )),
//                       ),
//                     ),
//                   )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20, bottom: 10),
//               child: TextFields(
//                 readOnly:
//                     AccountSettingController.isEdit == true ? false : true,
//                 controller: nameController,
//                 text: 'Matteo Berrettini',
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: TextFields(
//                 readOnly: AccountSettingController.isEdit == true &&
//                         BaseHelper.currentUser?.providerData.first.providerId
//                                 .toString() !=
//                             'facebook.com' &&
//                         BaseHelper.currentUser?.providerData.first.providerId
//                                 .toString() !=
//                             'google.com'
//                     ? false
//                     : true,
//                 controller: emailController,
//                 text: 'giocatore@wannaplay.it',
//               ),
//             ),
//             if (BaseHelper.currentUser?.providerData.first.providerId
//                         .toString() !=
//                     'google.com' &&
//                 BaseHelper.currentUser?.providerData.first.providerId
//                         .toString() !=
//                     'facebook.com')
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: TextFields(
//                   readOnly:
//                       AccountSettingController.isEdit == true ? false : true,
//                   controller: passwordController,
//                   text: '*************',
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: TextFields(
//                 readOnly: true,
//                 controller: dobController,
//                 text: '24/12/1995',
//               ),
//             ),
//             if (AccountSettingController.roleRadioAccount != 'Circolo')
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: TextFields(
//                   readOnly: true,
//                   controller: cityController,
//                   text: 'Milano',
//                 ),
//               ),
//             if (AccountSettingController.roleRadioAccount == 'Circolo')
//               Column(
//                 children: [
//                   Padding(
//                       padding: const EdgeInsets.only(top: 10, bottom: 20),
//                       child: TextFields(
//                         readOnly: true,
//                         onTap: BaseHelper.user?.address == "null" ||
//                                 BaseHelper.user?.address == ''
//                             ? () async {
//                                 await GooglePlaces.googlePlaccesLoc(context)
//                                     .then((value) {
//                                   if (value != "null") {
//                                     addressController.text = value.toString();
//                                   }
//                                 });
//                               }
//                             : null,
//                         controller: addressController,
//                         text: 'Address',
//                       )),
//                   Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Theme(
//                           data: Theme.of(context)
//                               .copyWith(dividerColor: Colors.transparent),
//                           child: Container(
//                             color: AppColor.textfield_color,
//                             child: ExpansionTile(
//                               title: AccountSettingController
//                                       .seviziItemAdded.isNotEmpty
//                                   ? Wrap(
//                                       children: AccountSettingController
//                                           .seviziItemAdded
//                                           .map((e) {
//                                         return Text(
//                                           "${e.toString()}, ",
//                                           style: subTitle16BlackStyle,
//                                         );
//                                       }).toList(),
//                                     )
//                                   : Text(
//                                       "Sevizi",
//                                       style: hint_text,
//                                     ),
//                               children: [
//                                 Container(
//                                   height: 15,
//                                   color: Colors.white,
//                                 ),
                              

                                
//             Padding(
//               padding: const EdgeInsets.only(
//                 top: 10,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "gender",
//                     style: TextStyle(),
//                   ),
//                   AccountSettingController.gender == 'M'
//                       ? CustomRadioButton(
//                           val: AccountSettingController.gender,
//                           value: "M",
//                           text: 'M',
//                           onChanged: ((value) async {}))
//                       : CustomRadioButton(
//                           val: AccountSettingController.gender,
//                           value: "F",
//                           text: 'F',
//                           onChanged: ((value) async {}))
//                 ],
//               ),
//             ),
           
         
               
               
//             CustomButton(
//                 // color: AppColor.buttonnewcolor,
//                 height: height * 0.05,
//                 width: width * 0.8,
//                 text:
//                     'Update',
//                 onpressed: () {
//                   if (emailController.text != BaseHelper.user?.email ||
//                       AccountSettingController.imageFile != '' ||
//                       AccountSettingController.gender !=
//                           BaseHelper.user?.gender ||
//                       !listEquals(BaseHelper.user?.campi,
//                           AccountSettingController.campiItemAdded) ||
//                       !listEquals(BaseHelper.user?.serviz,
//                           AccountSettingController.seviziItemAdded) ||
//                       nameController.text != BaseHelper.user?.name ||
//                       emailController.text != BaseHelper.user?.email ||
//                       passwordController.text != BaseHelper.user?.password ||
//                       dobController.text != BaseHelper.user?.dob ||
//                       cityController.text != BaseHelper.user?.city ||
//                       AccountSettingController.rankingRadioAccount !=
//                           BaseHelper.user?.isFederationRanking ||
//                       AccountSettingController.federationRankAccount !=
//                           BaseHelper.user?.federationRanking ||
//                       AccountSettingController.roleRadioAccount !=
//                           BaseHelper.user?.role ||
//                       federationLinkAccountController.text !=
//                           BaseHelper.user?.federationLink) {
//                     AccountSettingController.updateUserData(context,
//                         federationLinkAccountController:
//                             federationLinkAccountController.text,
//                         federationRankAccount:
//                             AccountSettingController.federationRankAccount,
//                         gender: AccountSettingController.gender,
//                         imageFile: AccountSettingController.imageFile,
//                         nameController: nameController.text,
//                         passwordController: passwordController.text,
//                         rankingRadioAccount:
//                             AccountSettingController.rankingRadioAccount,
//                         roleRadioAccount:
//                             AccountSettingController.roleRadioAccount,
//                         address: addressController.text,
//                         campList: AccountSettingController.campiItemAdded,
//                         email: emailController.text.toLowerCase().trim(),
//                         seviziList: AccountSettingController.seviziItemAdded);
//                   } else {
//                     widget.willPopValue == false &&
//                             AccountSettingController.roleRadioAccount ==
//                                 RoleName.none
//                         ? BaseHelper.showSnackBar(context, 'Update your Rolo')
//                         : Navigator.maybePop(context);
//                   }
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
