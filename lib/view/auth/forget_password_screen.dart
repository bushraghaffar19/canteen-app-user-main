import 'package:get/get.dart';

import '/Constant/constant.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_textfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width.toInt();
    final height =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Reset Password",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Image(
                  image: const AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                  width: width*.4,
                ),
                const SizedBox(height: 30,),
                Text("Please enter email for reset your password.",style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),),
                SizedBox(height: height*0.03,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                            controller: _emailTextEditController,
                            validator: (value) {
                              if (value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              else if(!EmailValidator.validate(value)){
                                return 'email address is not valid';
                              }
                              return null;
                            },
                            hintText: "Email"),
                      ],
                    )),
                const SizedBox(height: 30,),
                CustomButton(title: 'Reset Password',
                  function: (){
                    if(_formKey.currentState!.validate()){
                      userController.resetPassword(_emailTextEditController.text, context);
                    }
                  },
                  buttonColor: kButtonColor,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
