import '/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String hintText;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? hideText;
  final int? maxLine;
  final TextInputType? textInputType;
  const CustomTextField({
    required this.controller,
    this.textInputType,
    this.maxLine,
    required this.validator,
    required this.hintText,
    this.leadingIcon,
    this.trailingIcon,
    this.hideText,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black
      ),
      maxLines: maxLine ?? 1,
      controller: controller,
      obscureText: hideText??false,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: trailingIcon,
        prefix: leadingIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        hintStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: kLightGreyColor
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kLightGreyColor, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusColor: kButtonColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kButtonColor, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(8),
        ),

      ),
    );
  }
}