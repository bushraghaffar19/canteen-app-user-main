import 'dart:convert';
import 'package:canteen_ordering_user/view/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Constant/constant.dart';
import '../model/user_model.dart';
import '../view/dashboard/widgets/bottom_navigation_widgets.dart';
import '../widgets/custom_dialogue.dart';
import '/widgets/loading_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class UserController extends GetxController{
  static UserController instance = Get.find();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  Rx<UserModel> userOrderData = UserModel().obs;
  RxList<UserModel> allUsers = RxList<UserModel>([]);
  Rx<UserModel> userData = UserModel().obs;
  User? currentUser = FirebaseAuth.instance.currentUser;


  CollectionReference userReference =
  FirebaseFirestore.instance.collection('users');

  CollectionReference adminReference =
  FirebaseFirestore.instance.collection('Admin');

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    //binding all Streams
    currentUser = user;
    if (currentUser != null) {
      userData.bindStream(listenToUser());
      allUsers.bindStream(getAllUsers());
      categoryController.bindingStream();
      productController.bindingStream();
      canteenController.bindingStream();
      orderController.bindingStream();
    }

  }

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  Future<void> updateFCMDeviceToken() async{
    var token = await firebaseMessaging.getToken();
    await userReference.doc(currentUser?.uid).update({
      'Token':token,
    });
    firebaseMessaging.subscribeToTopic('allUsers');
  }

  Stream<UserModel> listenToUser() =>
      userReference.doc(firebaseUser.value?.uid)
          .snapshots()
          .map((snapshot) => UserModel.fromMap(snapshot.data()as Map<String, dynamic>));

  Stream<List<UserModel>> getAllUsers() =>
      userReference.snapshots().map((query) =>
          query.docs.map((item) => UserModel.fromMap(item.data() as Map<String, dynamic>)).toList());

  UserModel getCustomer(String id) =>
      allUsers.where((value) => value.uid == id).first;



  Future<void> signUp(UserModel userModel, context) async {
    loadingDialogue(context: context);
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: userModel.email ??'',
      password: userModel.password ??'',
    )
        .then((auth) {
      currentUser = auth.user;
      userReference.doc(currentUser!.uid).set({
        UserModel.userId: currentUser!.uid,
        UserModel.userEmail: currentUser!.email,
        UserModel.userName: userModel.name,
        UserModel.userPassword: userModel.password,
        UserModel.userMobile:userModel.mobile,
        UserModel.userType:userModel.type,
        UserModel.userGender:userModel.gender,
        UserModel.teaId:userModel.teacherId,
        UserModel.userDept:userModel.department
      }).then((value) async {
        Navigator.pop(context);
        Get.back();
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          colorText:Colors.black,
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        onError.message.toString(),
        colorText:Colors.black,
      );
    });
  }

  List token =[];
  Future<void> logIn(
      String email, password, context) async {
    loadingDialogue(context: context);
    // await sharedPreferences!.clear();
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((auth) async{
       currentUser = auth.user;
      // final dataSnapshot = await userReference
      //     .doc(currentUser!.uid)
      //     .get();
      // if(dataSnapshot.exists){
        if(currentUser != null){
          updateFCMDeviceToken();
           await adminReference
              .get().then((value) {
            //PreferenceManager().setToken = value.docs.first["Token"];
          });
          Navigator.pop(context);
          Get.offAll(() => const BottomNavScreen());
        }
      // }
      // else{
      //   Navigator.pop(context);
      //   firebaseAuth.signOut();
      //   Get.snackbar(
      //     "Something went wrong",
      //     "There is no user record corresponding to this identifier. The user may have been deleted.",
      //     backgroundColor: const Color(0x85ffffff),
      //   );
      // }
      }).catchError((onError) {
        Navigator.pop(context);
        Get.snackbar(
          "Something went wrong",
          onError.message.toString(),
          colorText:Colors.black,
        );
      });
  }
  Future<void> updateUserData(Map<String, dynamic> data) async{
    await userReference
        .doc(firebaseUser.value?.uid)
        .update(data);
  }
  Future<void> resetPassword(String email, context) async {
    loadingDialogue(context: context);
    await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
      Navigator.pop(context);
      customDialogue(context:context,title: "Check your email",bodyText: "We have sent a password recover instructions to your email",isBack:true);
    }).catchError((error) {
      Navigator.pop(context);
      Get.snackbar(
        "Something went wrong",
        error.message.toString(),
        colorText:Colors.black,
      );
    });
  }

  // Future<void> updateUserData(Map<String, dynamic> data,context) async{
  //   await userReference.doc(firebaseUser.value?.uid).update(
  //       data
  //   ).then((value) {
  //     Get.snackbar(
  //       "Successfully",
  //       "Details of user updated successfully",
  //       backgroundColor: const Color(0x85ffffff),
  //     );
  //   }
  //   ).catchError((e){
  //     Navigator.pop(context);
  //     customDialogue(
  //         title: "Something went wrong",
  //         bodyText: e.message.toString(),
  //         context: context
  //     );
  //   });
  // }

  Future<void> changeEmail(String newEmail , context) async{
    loadingDialogue(context: context,);
    User? user =  FirebaseAuth.instance.currentUser;
    user?.updateEmail(newEmail).then((value) {
      updateUserData({UserModel.userEmail:newEmail});
      Get.back();
      Get.back();
    }).catchError((e){
      Get.back();
      customDialogue(
          title: "Something went wrong",
          bodyText: e.message.toString(),
          context: context
      );
    });
  }

  Future<void> changePassword(String oldPassword, newPassword, context) async {
    String email = currentUser!.email!;
    loadingDialogue(context: context);
    firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: oldPassword,
    ).then((value) {
      currentUser?.updatePassword(newPassword).then((value) {
        updateUserData({UserModel.userPassword:newPassword});
        Get.back();
        Get.back();
      }).catchError((error) {
        Navigator.pop(context);
        customDialogue(
            title: "Something went wrong",
            bodyText: error.message.toString(),
            context: context
        );
      });
    }).catchError((onError) {
      Navigator.pop(context);
      customDialogue(
          title: "Something went wrong",
          bodyText: onError.message.toString(),
          context: context
      );
    });
  }

  void  signOut ()async{
    await firebaseAuth.signOut();
    Get.offAll(const LoginScreen());
  }


  Future<void> sendNotification(String notificationTitle, String notificationBody, String targetFCMToken) async {
    const String url = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'key=AAAAjvP13VY:APA91bEE4WT_HMJj0jMF9djhDRHemD4Qho4LZyIt8q3pFEXufOndyaFvOmiAEvFiMoU1e4RUzYCV4XTv0RGirhdSWKKe2X08a05N-Pke57FquApiWVLN0MCYtVyCQ9V6NJgKFXykiTnj';

    Map<String, dynamic> body = {};
    body['notification'] = {
      'title': notificationTitle,
      'body': notificationBody,
      'sound': 'default'
    };
    body['priority'] = 'high';
    body['data'] = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done'
    };
    body['to'] = targetFCMToken;
    await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body),);

  }

}