import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:canteen_ordering_user/model/cart_model.dart';
import 'package:canteen_ordering_user/view/dashboard/checkout/place_order_successfully.dart';
import 'package:canteen_ordering_user/view/dashboard/checkout/widgets/show_payment_method_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../stripe/stripe_process_payment.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loading_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _addressTextEditingController = TextEditingController();
  int selectedIndex = 0;
  final List<String> _images = [
    "assets/images/counter.png",
    "assets/images/card.png",
    "assets/images/easypaisa.png",
    "assets/images/jazzcash.png",
  ];
  final List<String> _methodName = [
    "Pay on counter",
    "Card Payment",
    "EasyPaisa",
    "JazzCash"
  ];
  String selectedMethod = '';
  @override
  void initState() {
    super.initState();
    selectedMethod = _methodName[selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout",
          style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         userController.userData.value.type == "Student" ? const SizedBox() :
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: Text("Teacher Room #",
                     style: GoogleFonts.inter(
                         fontSize: 18,
                         fontWeight: FontWeight.w700,
                         color: Colors.black
                     ),),
                 ),
                 const SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: CustomTextField(
                       controller: _addressTextEditingController,
                       validator: (value) {
                         if (value.trim().isEmpty) {
                           return 'Please enter your room no';
                         }
                         else if(value.length < 3 ){
                           return 'field contains at least 3 characters';
                         }
                         return null;
                       },
                       hintText: "Room No"),
                 ),
               ],
             ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Payment Method",
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black
              ),),
          ),
          const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: _images.length,
                  shrinkWrap: true,
                  itemBuilder: (context,i){
                    return ShowPaymentMethodWidget(
                      methodName: _methodName[i],
                      url: _images[i],
                      onTap: (){
                        setState(() {
                          selectedIndex = i;
                          selectedMethod =  _methodName[i];
                          print(selectedMethod);
                        });
                      },
                      selectedIndex: selectedIndex,
                      index: i,
                    );
                  }),
            ),
          Container(
            width: w,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 30.0,
                  spreadRadius: 5.0,
                ), //BoxShadow
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Total price :",style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kLightGreyColor
                    ),),
                    const Spacer(),
                    Obx(() =>Text("RS.${cartController.totalCartPrice.value}",style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kButtonColor
                    ),),)
                  ],
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    // Get.to(() => const OrderPlaceSuccessfully());
                    if(selectedIndex == 2 ||selectedIndex == 3){
                      Get.snackbar("Not defined",
                          "This payment is not defined yet please select another method",
                        colorText: Colors.black
                      );
                    }
                    else if(selectedIndex == 0){
                      loadingDialogue(context:context,);
                      orderController.roomNo = _addressTextEditingController.text;
                      orderController.paymentStatus = 'pending';
                      orderController.paymentMethod = selectedMethod;
                      orderController.placeOrder(context);
                    }
                    else{
                      orderController.roomNo = _addressTextEditingController.text;
                      orderController.paymentStatus = 'Success';
                      orderController.paymentMethod = selectedMethod;
                      StripProcessPayment().makePayment(context);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                    height: 60,
                    decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        Text("Proceed to payment",style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),),
                        const Spacer(),
                        Card(
                          elevation: 10,
                          color: kLightTextColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(CupertinoIcons.arrow_right,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
