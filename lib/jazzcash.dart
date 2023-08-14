import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import '../model/product_model.dart';
import 'jazzcash_payment.dart';


class JazzCashScreen extends StatefulWidget {
  const JazzCashScreen({Key? key})
      : super(key: key);

  @override
  State<JazzCashScreen> createState() => _JazzCashScreenState();
}

class _JazzCashScreenState extends State<JazzCashScreen> {
  String paymentStatus = "pending";
  // ProductModel productModel = ProductModel("Product 1", "100");
  String integritySalt = "3u1yvd43e3";
  String merchantID = "MC58187";
  String merchantPassword = "sy38ewfdte";
  String transactionUrl =
      "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
  // String transactionUrl= "jazzcashtest://payment-response";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Product Name : Burger"),
            Text("Product Price : 500"),
            ElevatedButton(
                onPressed: () {
                  _payViaJazzCash(context);
                },
                child: const Text("Confirm to Purchase Now !"))
          ],
        ),
      ),
    );
  }

  Future _payViaJazzCash(BuildContext c) async {
    //print("clicked on Product ${element.productName}");

    try {
      JazzCashFlutter jazzCashFlutter = JazzCashFlutter(
        merchantId: merchantID,
        merchantPassword: merchantPassword,
        integritySalt: integritySalt,
        isSandbox: true,
      );

      DateTime date = DateTime.now();

      JazzCashPaymentDataModelV1 paymentDataModelV1 =
      JazzCashPaymentDataModelV1(
        ppAmount: '500',
        ppBillReference:
        'refbill${date.year}${date.month}${date.day}${date.hour}${date.millisecond}',
        ppDescription:
        'Product details  Burger - 500',
        ppMerchantID: merchantID,
        ppPassword: merchantPassword,
        ppReturnURL: transactionUrl,
      );

      jazzCashFlutter
          .startPayment(
          paymentDataModelV1: paymentDataModelV1, context: context)
          .then((_response) {
        print("response from jazzcash .Payment is processed");

        /*List<dynamic> news = [];
        for (int i = 0; i < maindata!["Purchased"].length; i++) {
          news.add(maindata!["Purchased"][i]);
        }
        print(maindata!["Name"]);
        news.add(widget.postsData.id);
        print(news);
        FirebaseFirestore.instance
            .collection("Users")
            .doc(login)
            .update({"Purchased": news});
        print(maindata!.id);*/
        //String logid = widget.collectionReference.parent!.id;
        // List<dynamic> soldItems = [];
        // for (int i = 0;
        // i < widget.docssnap["Sold"].length;
        // i++) {
        //   soldItems.add(widget.docssnap["Sold"][i]);
        // }
        // soldItems.add(widget.postsData.id);
        // FirebaseFirestore.instance
        //     .collection("Users")
        //     .doc(logid)
        //     .update({"Sold": soldItems});
       /* Map<String, dynamic> maps = {};
        List<dynamic> items = [];
        for (int i = 0; i < widget.docssnap['Solds']['Items'].length; i++) {
          items.add(widget.docssnap['Solds']['Items'][i]);
        }
        items.add(widget.postsData.id);

        List<dynamic> Timestamps = [];
        for (int i = 0;
        i < widget.docssnap['Solds']['Timestamps'].length;
        i++) {
          Timestamps.add(widget.docssnap['Solds']['Timestamps'][i]);
        }
        Timestamps.add(DateTime.now());
        maps = {"Items": items, "Timestamps": Timestamps};
        FirebaseFirestore.instance
            .collection("Users")
            .doc(logid)
            .update({"Solds": maps});
        print(items);
        print(Timestamps);*/

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Checkout(),
        ));

        setState(() {});
      });
    } catch (err) {
      print("Error in payment can't Processed");
      // CommonFunctions.CommonToast(
      //   message: "Error in payment $err",
      // );
      return false;
    }
  }
}

// class ProductModel {
//   String? productName;
//   String? productPrice;
//
//   ProductModel(this.productName, this.productPrice);
// }