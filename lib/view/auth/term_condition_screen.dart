import 'package:canteen_ordering_user/Constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermAndConditions extends StatelessWidget {
  const TermAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text(" Welcome to Foodie. By using our services, you agree to comply with and be bound by the following terms and conditions."
                  " Please read these terms carefully before using our app:",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
              const SizedBox(height: 20,),
              Text("Acceptance of Terms:",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("By accessing and using Foodie, you acknowledge that you have read, "
                  "understood, and agreed to abide by these terms and conditions, as well as our Privacy Policy.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
              const SizedBox(height: 20,),
              Text("Ordering Food:",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("Our app allows you to place orders for food from various canteen and eateries. "
                  "The accuracy of the order details, including delivery location, food items, and any specific dietary preferences,"
                  " is your responsibility.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
              const SizedBox(height: 20,),
              Text("User Account:",style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),),
              const SizedBox(height: 10,),
              Text("To place orders through our app, you may be required to create a user account. "
                  "You are responsible for maintaining the confidentiality of your account credentials and "
                  "for all activities that occur under your account.",style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: kLightGreyColor
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
