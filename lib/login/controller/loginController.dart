
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:login_to_api/login/model/loginModel.dart';
import 'package:login_to_api/services/api/ApiEndPoint.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:login_to_api/services/repo/CommonRepo.dart';
class LoginController extends GetxController {
  late EmailModel _emailModel;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var activeIndex=0.obs ;
  var pageIndex=0.obs;

  @override
  void onInit() {
    super.onInit();

  }
  singup() async{
    // Uri url= Uri.parse(ApiEndpoint.baseUrl+ApiEndpoint.postEmail);
    // final userdata = Data(
    //   email: emailController.text,
    //   phone: phoneController.text
    // );
    EmailModel emailModel = await ApiController().submitData(email: emailController.text,password: passwordController.text);

    if(emailModel.code ==200){
      Fluttertoast.showToast(
          msg: emailModel.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }

}