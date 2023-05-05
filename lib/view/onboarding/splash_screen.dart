import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../auth/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // body: Stack(
      //   children: <Widget>[
      //     Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       color: kBackgroundColor,
      //       child: Center(
      //         child: SizedBox(
      //             height: 200,
      //             width: 200,
      //             child: Image.asset("assets/images/logo.png")),
      //       ),
      //     ),
      //   ],
      // ),
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Container(
            width: 200,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff0f2057).withOpacity(.5),
                    blurRadius: 15)
              ],

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10,),
                 LinearPercentIndicator(
                  animation: true,
                  lineHeight: 15.0,
                  animationDuration: 1500,
                  percent: 1.0,
                  barRadius: const Radius.circular(30),
                  progressColor: kButtonColor,
                ),
              ],
            )

        ),
        nextScreen: const LoginScreen(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 200,
        backgroundColor: Colors.white,
      ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
