import 'package:flutter/material.dart';

import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/utilis/app_typography.dart';
import 'package:voter_app/utilis/validators.dart';
import 'package:voter_app/widget/app_bar_widget.dart';
import 'package:voter_app/widget/custom_button_widget.dart';
import 'package:voter_app/widget/textfield_widget.dart';


import '../../Controller/auth_controller.dart';

import 'recover_password.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool obsecureVar = true;
  late GlobalKey<FormState> formKey;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();

    emailController = TextEditingController();
    passwordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.reset();
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget(
          background: Colors.transparent,
          title:"Log in",
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          decoration: const BoxDecoration(
            // image: DecorationImage(

            //     fit: BoxFit.cover,
                
            //      image: AssetImage(ImagePath.spalsh)
            //      ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.04
                        : height * 0.019),
                SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.1
                        : height * 0.3,
                    width: MediaQuery.of(context).viewInsets.bottom > 100
                        ? height * 0.1
                        : height * 0.4,
                    // child: Image.asset(ImagePath.spalshico
                    
                    // )
                    
                    ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 100
                      ? height * 0.04
                      : height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: TextFields(
                    controller: emailController,
                    validator: (p0) => Validators.validateEmail(p0),
                    text:"Enter Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: TextFields(
                    controller: passwordController,
                    validator: (p0) => Validators.validatePassword(p0),
                    obsecureText: obsecureVar,
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
                    text:"Enter Password",
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomButton(
                  style: subTitle16lightGreenstyle,
                  height: height * 0.06,
                  width: width * 0.8,
                  text: "Log In",
                  onpressed: () {
                    if (formKey.currentState!.validate()) {
                      Auth.logInAuth(context,
                          email: emailController.text,
                          password: passwordController.text);
                    } else {
                      return;
                    }
                    // Navigator.of(context).push((MaterialPageRoute(
                    //     builder: (context) => const ProfileGecatore())));
                  },
                ),
                CustomButton(
                      color: AppColor.divivdercolor,
                      height: height * 0.06,
                      width: width * 0.8,
                      text: "Login",
                      style: subTitle16DarkGreyStyle.copyWith(fontSize: 22),
                      onpressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                          (route) => false,
                        );
                      }),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push((MaterialPageRoute(
                          builder: (context) => const RecoverPassword())));
                    },
                    child:  const Text(
                     "Forgot Password",
                      style: TextStyle(color: AppColor.maincolor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
