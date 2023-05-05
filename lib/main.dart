import 'dart:math';
import 'package:canteen_ordering_user/controller/canteen_controller.dart';
import 'package:canteen_ordering_user/controller/cart_controller.dart';
import 'package:canteen_ordering_user/controller/order_controller.dart';
import 'package:canteen_ordering_user/controller/review_controller.dart';
import 'package:canteen_ordering_user/view/dashboard/widgets/bottom_navigation_widgets.dart';
import 'package:canteen_ordering_user/view/onboarding/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'Constant/constant.dart';
import 'controller/category_controller.dart';
import 'controller/product_controller.dart';
import 'controller/user_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  await Firebase.initializeApp().then((value) {
    Get.put(UserController());
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(CanteenController());
    Get.put(CartController());
    Get.put(OrderController());
    Get.put(ReviewController());
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }
  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cafeteria App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: generateMaterialColor(kButtonColor),
        primaryColor: kButtonColor,
        brightness: Brightness.light,
        primaryColorDark: kBackgroundColor,
        iconTheme: const IconThemeData(
          color: kButtonColor
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: kButtonColor
          )
        ),
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: FirebaseAuth.instance.currentUser ==null? const Splash() : const BottomNavScreen(),
    );
  }
}



