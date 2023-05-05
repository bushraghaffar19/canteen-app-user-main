import 'dart:io';
import 'package:canteen_ordering_user/controller/image_controller.dart';
import 'package:canteen_ordering_user/model/user_model.dart';
import 'package:canteen_ordering_user/widgets/custom_dialogue.dart';
import 'package:canteen_ordering_user/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../../Constant/constant.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({Key? key}) : super(key: key);

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final TextEditingController _nameTextEditController = TextEditingController();
  final TextEditingController _phoneNoTextEditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  @override
  void initState() {
    super.initState();
    _nameTextEditController.text = userController.userData.value.name??"your name";
    _phoneNoTextEditController.text = userController.userData.value.mobile??"your name";
  }
  @override
  void dispose() {
    _nameTextEditController.dispose();
    _phoneNoTextEditController.dispose();
    super.dispose();
  }
  Future pickImage() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file == null) return null;
    setImage(File(file.path));
  }
  void setImage(File? newImage) {
    setState(() {
      image = newImage;
    });
  }

  Widget? _imageWidget(BuildContext context){
    if(image == null && userController.userData.value.profile == null){
    return const Icon(
        Icons.add_a_photo,
        size: 40,
        color: Colors.white,
      );
    }
    else if(image != null) {
      return Image(
        image: FileImage(image!),
        fit: BoxFit.cover,
        width: 120.0,
        height: 120.0,
      );
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: kLightGreyColor,
                    backgroundImage: userController.userData.value.profile != null?NetworkImage(userController.userData.value.profile!):null,
                    child: ClipOval(
                        child: _imageWidget(context)),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(color: Colors.white,
                                width: 2
                            )
                        ),
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          } ,
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: kButtonColor,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameTextEditController,
                      hintText: 'Enter your new name',
                      validator: (value) {
                        final RegExp namePattern = RegExp(r"^[a-zA-Z ]*$");
                        if (value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        else if(value.length < 3 ){
                          return 'name field contains at least 3 characters';
                        }
                        else if (!namePattern.hasMatch(value)) {
                          return 'Name is invalid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15,),
                    CustomTextField(
                        textInputType: TextInputType.number,
                        controller: _phoneNoTextEditController,
                        validator: (value) {
                          String pattern = r'(^(?:[+0]9)?[0-9]{11,12}$)';
                          RegExp regExp =  RegExp(pattern);
                          if (value
                              .trim()
                              .isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
                        hintText: "Phone Number"),
                  ],
                )
              ),
              const SizedBox(height: 30,),
              CustomButton(
                  title: 'Save',
                  textColor: Colors.black,
                  buttonColor: kButtonColor,
                  function:() {
                    if(image == null && userController.userData.value.profile == null){
                      customDialogue(
                          title: "Something went wrong",
                          bodyText: 'Please select image from gallery',
                          context: context
                      );
                    }
                    else if(image == null && _formKey.currentState!.validate()){
                      loadingDialogue(context: context,);
                      userController.updateUserData({
                        UserModel.userProfile:userController.userData.value.profile,
                        UserModel.userName:_nameTextEditController.text.trim(),
                        UserModel.userMobile:_phoneNoTextEditController.text.trim(),
                      });
                      Navigator.pop(context);
                      Get.back();
                    }
                    else if(_formKey.currentState!.validate()){
                      ImageController().uploadImageToFirebase('User Images',_nameTextEditController.text,image!,context).then((url) {
                        setState(() {
                          userController.updateUserData(
                              {
                                UserModel.userProfile:url,
                                UserModel.userName:_nameTextEditController.text.trim(),
                                UserModel.userMobile:_phoneNoTextEditController.text.trim(),
                              },);
                          Navigator.pop(context);
                          Get.back();
                        });
                      }).catchError((error) {
                        Navigator.pop(context);
                        Get.snackbar(
                          "Something went wrong",
                          error.message.toString(),
                          backgroundColor: const Color(0x85ffffff),
                        );
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
