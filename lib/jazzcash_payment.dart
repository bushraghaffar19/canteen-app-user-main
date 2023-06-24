import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JazzCash {
  var responsePrice;
  bool isLoading = false;

  Future<void> payment() async {
    var digest;
    String dateAndTime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String expireDate = DateFormat("yyyyMMddHHmmss")
        .format(DateTime.now().add(const Duration(days: 1)));
    String tre = "T" + dateAndTime;
    String ppAmount = "500"; // price set
    String ppBillReference = "billRef";
    String ppDescription = "Description for transaction";
    String ppLanguage = "EN";
    String ppMerchantID = "Your MID";
    String ppPassword = "Your password";
    String ppReturnURL =
        "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String ppVer = "1.1";
    String ppTxnCurrency = "PKR";
    String ppTxnDateTime = dateAndTime.toString();
    String ppTxnExpiryDateTime = expireDate.toString();
    String ppTxnRefNo = tre.toString();
    String ppTxnType = "MWALLET";
    String ppmpf1 = "4456733833993";
    String integritySalt = "Your salt";
    String and = '&';
    String superdata = integritySalt +
        and +
        ppAmount +
        and +
        ppBillReference +
        and +
        ppDescription +
        and +
        ppLanguage +
        and +
        ppMerchantID +
        and +
        ppPassword +
        and +
        ppReturnURL +
        and +
        ppTxnCurrency +
        and +
        ppTxnDateTime +
        and +
        ppTxnExpiryDateTime +
        and +
        ppTxnRefNo +
        and +
        ppTxnType +
        and +
        ppVer +
        and +
        ppmpf1;

    var key = utf8.encode(integritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    String url =
        'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(
      Uri.parse(url),
      body: {
        "pp_Version": ppVer,
        "pp_TxnType": ppTxnType,
        "pp_Language": ppLanguage,
        "pp_MerchantID": ppMerchantID,
        "pp_Password": ppPassword,
        "pp_TxnRefNo": tre,
        "pp_Amount": ppAmount,
        "pp_TxnCurrency": ppTxnCurrency,
        "pp_TxnDateTime": dateAndTime,
        "pp_BillReference": ppBillReference,
        "pp_Description": ppDescription,
        "pp_TxnExpiryDateTime": expireDate,
        "pp_ReturnURL": ppReturnURL,
        "pp_SecureHash": sha256Result.toString(),
        "ppmpf_1": ppmpf1,
      },
    );

    print("response=>");
    print(response.body);
    var res = await response.body;
    var body = jsonDecode(res);
    responsePrice = body['pp_Amount'];
    Fluttertoast.showToast(msg: "payment successfully $responsePrice");
  }
}
