import 'package:canteen_ordering_user/controller/canteen_controller.dart';
import 'package:canteen_ordering_user/controller/cart_controller.dart';
import 'package:canteen_ordering_user/controller/order_controller.dart';
import 'package:canteen_ordering_user/controller/review_controller.dart';
import 'package:flutter/material.dart';

import '../controller/category_controller.dart';
import '../controller/product_controller.dart';
import '../controller/user_controller.dart';


const  kBackgroundColor = Colors.white;
const kButtonColor = Color(0xffd26822);
const kLightButtonColor = Color(0xffd26822);
const kLightTextColor = Color(0xffe0905e);
const kButtonTextColor = Colors.white;
const kLightGreyColor = Color(0xffa9aeb4);
const kYellowColor = Color(0xfff7bc00);


UserController userController = UserController.instance;
CategoryController categoryController = CategoryController.instance;
ProductController productController = ProductController.instance;
CanteenController canteenController = CanteenController.instance;
CartController cartController = CartController.instance;
OrderController orderController = OrderController.instance;
ReviewController reviewController = ReviewController.instance;


const String stripeBaseURL = 'https://api.stripe.com/';
const String createPaymentMethodURL = 'v1/payment_methods';
const String createPaymentIntentURL = 'v1/payment_intents';
const String confirmPaymentIntentURL = 'v1/payment_intents/replace_me/confirm';
const String stripeSecretKey = 'sk_test_51MNdziF8oTHvhnq3FE0GZfXbgdM9hGMVkA3kpjsdpg3wgnXWqGbW4sfWCxpwR2TTuhzaKjAnh2z0iXbMcHlfCzcp000Ht9507U';
const String stripePublishableKey ='pk_test_51MNdziF8oTHvhnq31ifqcL44XKoC4yGVIF0jLgYhCkkXSUEiWGWsUZZyAlr31F3ng4Q02XoC28rZsyb00SXPPDZK00JhJ7k3lk';
