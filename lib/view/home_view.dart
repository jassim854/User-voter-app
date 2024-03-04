import 'package:flutter/material.dart';
import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/utilis/app_typography.dart';
import 'package:voter_app/view/qrScanner/qr_scanner_view.dart';
import 'package:voter_app/widget/custom_button_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(body: Column(children: [
       CustomButton(
                      color: AppColor.divivdercolor,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: "",
                      style: subTitle16DarkGreyStyle.copyWith(fontSize: 22),
                      onpressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScanner()),
                          (route) => false,
                        );
                      }),
    ],),);
  }
}