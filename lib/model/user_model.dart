import 'package:cloud_firestore/cloud_firestore.dart';


class 
UserModel {

  final String name;
  final String email;
  final String password;
  final String? phoneNumber;
  final String? dob;
  final String city;
  final String? address;
  final String? gender;

  final String profilePhoto;

  final String? deviceToken;
  final String? status;


  UserModel(
      {required this.profilePhoto,

      this.dob,
      required this.city,
      this.gender,

      required this.name,
      required this.password,
      required this.email,
      this.address,

      this.phoneNumber,


      this.deviceToken,


      this.status,
     });

  // Map<String, dynamic> toFireStore() {
  //   return {

  //     "name": name,
  //     "email": email,
  //     "password": password,
  //     "phoneNumber": phoneNumber,
  //     "address": address,

  //     "dob": dob,
  //     "city": city,
  //     "gender": gender,



  //     "profilePhoto": profilePhoto,


  //     "device_token": deviceToken,
  //     "status": status,

  //   };
  // }

  factory UserModel.fromFireStore(
      Map<String, dynamic> data,
      ) {
  
    return UserModel(

        name: data?["name"] ??= "",
   
        city: data?["city"] ??= "",
        gender: data?["gender"] ??= "",

        dob: data?["dob"] ??= "",
        email: data?["email"] ??= "",

    
        profilePhoto: data?["profilePhoto"] ??= "",
 
        deviceToken: data?['device_token'] ??= "",
        status: data?['status'] ??= "",
        password: data?["password"] ??= "",
        address: data?["address"] ??= "",
    
        phoneNumber: data?["phoneNumber"] ??= '');
      
  }
}

