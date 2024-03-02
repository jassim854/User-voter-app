// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/utilis/app_typography.dart';



class TextFields extends StatelessWidget {
  String text;
  double? height;
  double? width;
  Widget? suffixicon;
  TextStyle? textStyle;
  TextAlign? textAligns;
  TextEditingController? controller;
  bool? obsecureText;
  int? minLines, maxLines;
  bool? readOnly;
  Function(String?)? onChanged;
  String? Function(String?)? validator;
  Function()? onTap;
  Function(String)? onSubmitted;
  TextFields(
      {Key? key,
      required this.text,
      this.height,
      this.width,
      this.textStyle,
      this.suffixicon,
      this.textAligns,
      this.controller,
      this.obsecureText,
      this.onChanged,
      this.onTap,
      this.readOnly,
      this.onSubmitted,
      this.maxLines,
      this.minLines,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines != null
          ? null
          : height ?? MediaQuery.of(context).size.height * 0.055,
      child: TextFormField(
        // autofillHints: [AutofillHints.email],
        minLines: minLines,
        maxLines: maxLines ?? 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        controller: controller,
        obscureText: obsecureText ?? false,
        style: textStyle,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        validator: validator,
        textAlign: textAligns ?? TextAlign.start,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15, top: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
            filled: true,
            fillColor: AppColor.textfield_color,
            suffixIcon: suffixicon,
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.refusecolor)),
            focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.refusecolor)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            hintText: text,
            hintStyle: subTitle16LightGreyStyle),
      ),
    );
  }
}
