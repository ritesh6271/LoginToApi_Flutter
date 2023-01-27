import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:login_to_api/login/controller/loginController.dart';

class LoginPage extends StatelessWidget{
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    var child = Scaffold(
      //backgroundColor: colorPrimary,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 150,),
            child: Column(

              children: [
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(right: 300),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                              )
                            ]
                        ),
                        height: 60,
                        child: TextField(
                          controller: loginController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xff5ac18e),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 270),
                        child: Text(
                          'Password',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0,2)
                              )
                            ]
                        ),
                        height: 60,
                        child: TextField(
                          controller: loginController.passwordController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.black
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14),
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xff5ac18e),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.black
                              )
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: ()async{
                      await loginController.singup();

                    },
                    child: Text("Submit"),
                  ),
                    // child: Button(
                    //     textContent: 'Login',
                    //     onPressed: (){("Button Clicked");
                    //     }
                )


              ],
            ),
          ),
        ),
      ),

    );

    widgetList.add(child);

    return Stack(children: widgetList);


  }

}