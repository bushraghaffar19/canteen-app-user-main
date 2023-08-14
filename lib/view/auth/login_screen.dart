import 'package:canteen_ordering_user/view/auth/forget_password_screen.dart';
import 'package:canteen_ordering_user/view/auth/signup_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/constant.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../dashboard/widgets/bottom_navigation_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditController = TextEditingController();

  final TextEditingController _passwordTextEditController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscure = true;

  void visibility(){
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70,),
                 Image(
                  image: const AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                  width: width*.4,
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Login Here",style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                  ),),
                ),
                const SizedBox(height: 30),
                SizedBox(height: height*0.025,),
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
                              else if(!EmailValidator.validate(value))
                              {
                                return 'email address is not valid.\n Please remove extra space if any';
                              }
                              return null;
                            },
                            hintText: "Email"),
                        SizedBox(height: height*0.023,),
                        CustomTextField(
                          controller: _passwordTextEditController,
                          hideText: obscure,
                          trailingIcon: obscure ? IconButton(
                            icon: const Icon(Icons.remove_red_eye,
                              color: kButtonColor,),
                            onPressed: visibility,
                          ) : IconButton
                            (onPressed: visibility,
                              icon: const Icon(Icons.visibility_off,
                                color: kButtonColor,
                              )),
                          hintText: "Password",
                          validator:(value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },),
                      ],
                    )),
                SizedBox(height: height*0.015,),
                GestureDetector(
                  onTap: (){
                    Get.to(() => const ForgetPasswordScreen(),
                        duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                        transition: Transition.cupertinoDialog
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kButtonColor
                    ),),
                  ),
                ),
                const SizedBox(height: 30,),
                CustomButton(
                  title: 'Sign In',
                  function: (){
                    if(_formKey.currentState!.validate()){
                      userController.logIn(_emailTextEditController.text, _passwordTextEditController.text, context);
                    }
                  },
                  buttonColor: kButtonColor,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: kLightGreyColor
                    ),),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(() => const SignUpScreen(),
                            duration: const Duration(seconds: 2), //duration of transitions, default 1 sec
                            transition: Transition.cupertinoDialog
                        );
                      },
                      child: Text("Sign Up",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                            decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          color: kButtonColor
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
