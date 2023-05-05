import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constant/constant.dart';

class ShowPaymentMethodWidget extends StatelessWidget {
  final String url;
  final String methodName;
  final VoidCallback onTap;
  final int selectedIndex;
  final int index;
  const ShowPaymentMethodWidget({
    required this.url,
    required this.selectedIndex,
    required this.index,
    required this.methodName,
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0,horizontal: 10),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.07),
                  spreadRadius: 3,
                  blurStyle: BlurStyle.normal,
                  blurRadius: 20,
                  offset:
                  const Offset(1, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color(0xffFFF7F1),
                      borderRadius: BorderRadius.circular(30)),
                  child:  Center(
                    child: Image(
                      image: AssetImage(url),
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  methodName,
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const Spacer(),
                selectedIndex == index ? _selectedMethod():_unSelectedMethod()
              ],
            )),
      ),
    );
  }
}

Widget _selectedMethod(){
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(30)),
    child:  const Center(
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 14,
      ),
    ),
  );
}
Widget _unSelectedMethod(){
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
        border: Border.all(color: kLightGreyColor),
        borderRadius: BorderRadius.circular(30)),
  );
}