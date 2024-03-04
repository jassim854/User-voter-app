import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:voter_app/utilis/app_colors.dart';
import 'package:voter_app/view/auth_/signup_player_view.dart';
import 'firebase_options.dart';
void main()async {
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: EasyLoading.init(
                builder: (context, child) {
                  EasyLoading.instance
                    ..indicatorType = EasyLoadingIndicatorType.ring
                    ..loadingStyle = EasyLoadingStyle.custom
                    ..indicatorSize = 40
                    ..radius = 10
                    ..textColor = AppColor.blackcolor
                    ..backgroundColor = AppColor.maincolor
                    ..indicatorColor = AppColor.textfield_color
                    ..maskColor = AppColor.blackcolor
                    ..userInteractions = false
                    ..dismissOnTap = false;
                  return Container(
                    child: child,
                  );
                },
              ),
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignupPlayerView()
    );
  }
}
