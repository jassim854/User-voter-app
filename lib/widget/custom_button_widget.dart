// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/utilis/app_typography.dart';



class CustomButton extends StatelessWidget {
  String text;
  double? height;
  double? width;
  TextStyle? style;
  Color? color;
  String? imgpath;
  double? radius;
  void Function()? onpressed;
  CustomButton({
    Key? key,
    required this.text,
    this.height,
    this.width,
    this.style,
    this.color,
    this.imgpath,
    this.radius,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 17),
            color: color ?? AppColor.maincolor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: style ?? subTitle16DarkGreyStyle,
            ),
            SizedBox(
              width: width! * 0.06,
            ),
            if (imgpath != null) Image.asset(imgpath!),
          ],
        ),
      ),
    );
  }
}
