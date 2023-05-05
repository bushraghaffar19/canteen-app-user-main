import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback function;
  final Color buttonColor;
  final Color textColor;
    const CustomButton({required this.textColor , required this.buttonColor,required this.title,required this.function , Key? key,}): super(key: key);
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final h = MediaQuery.of(context).size.height.toInt();
    return Container(
      height: h*.06,
      width: double.infinity,
      margin: const EdgeInsets.all(0),
      child: MaterialButton(
        elevation: 0,
        color: buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: function,
        child: Text(title, style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kButtonTextColor
        ),),
      ),
    );
  }
}