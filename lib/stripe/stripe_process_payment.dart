
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Constant/constant.dart';
import '../widgets/loading_widget.dart';

class StripProcessPayment{
  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment(context) async {
    try {
     loadingDialogue(context:context,);
     int amount = (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) * 100).toInt();
      paymentIntentData = await createPaymentIntent(amount);
       print('Payment Intent Response==>${paymentIntentData.toString()}');
       if(paymentIntentData?['error'] != null){
         Navigator.pop(context);
         Get.snackbar(
           'Something went wrong',
           paymentIntentData?['error']['message'] ??'',
             colorText: Colors.black
         );
       }
       else{
         Navigator.pop(context);
            await Stripe.instance.initPaymentSheet(
             paymentSheetParameters: SetupPaymentSheetParameters(
                 paymentIntentClientSecret: paymentIntentData!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
                  // googlePay:  const PaymentSheetGooglePay(merchantCountryCode: '+92',testEnv: true),
                 style: ThemeMode.light,
                 merchantDisplayName: 'ANNIE')).then((value){

         });
         displayPaymentSheet(context);
       }
      ///now finally display payment sheeet
    } catch (e, s) {
      Navigator.pop(context);
      print('exception:$e$s');
    }
  }
  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue){
        print('payment intent'+paymentIntentData.toString());
        paymentIntentData = null;
         orderController.placeOrder(context);
         Get.snackbar(
             "Success",
             "Successfully paid",
           colorText: Colors.black
         );

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error');
        Get.snackbar(
            "Something went wrong",
             "The payment flow has been canceled",
            colorText: Colors.black
        );
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      Get.snackbar(
          "Something went wrong",
          e.error.message ??"error occur",
          colorText: Colors.black
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<dynamic> createPaymentIntent(int price) async {
    try {
      Map<String, dynamic> body = {
        'amount': price.toString(),
        'currency': 'PKR',
        'payment_method_types[]': 'card'
      };
      http.Response? response = await http.post(
        Uri.parse('$stripeBaseURL/$createPaymentIntentURL'),
        headers: <String, String>{'Authorization': 'Bearer $stripeSecretKey'},
        body: body,
      );
      return jsonDecode(response.body);
    } catch (exception) {
      log(exception.toString());
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }
}