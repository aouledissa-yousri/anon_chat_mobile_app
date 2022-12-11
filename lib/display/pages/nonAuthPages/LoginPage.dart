import 'dart:convert';
import 'dart:io';
import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/DashBoardPage.dart';
import 'package:flutter/material.dart';

import '../../../helpers/DirectoryHelper.dart';
import '../../../models/User.dart';
import '../../../services/UserManagementService.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loginButton = false;



  @override
  void dispose(){
    super.dispose();
    this.usernameController.dispose();
    this.passwordController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 30),
                onPressed: () => back(context)
              ),
              margin: EdgeInsets.only(bottom: 50),
              alignment: Alignment.topLeft,
            ),
    
    
            TextField(
              decoration: InputDecoration(
                hintText: "Enter username",
                icon: Icon(Icons.person, color: Color.fromARGB(255, 8, 221, 193)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
              ),
              controller: usernameController,
              onChanged: (text){this.activateLogin();},
            ),
    
    
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
                icon: Icon(Icons.lock, color: Color.fromARGB(255, 8, 221, 193))
              ),
              controller: passwordController, 
              onChanged: (text){this.activateLogin();},
            ),
    
            Text("   "),
    
            SizedBox(
              width: double.infinity,
              height: 30,
              child:  ElevatedButton(
                
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))
                  )
                ),
    
    
                child: Text("Login"),
                onPressed: this.loginButton ? () => this.login() : null
              )
            ),
    
    
          ],
        )
      ),
    );
  }


  void activateLogin(){
    if(this.usernameController.text != "" && this.passwordController.text != "") 
      setState(() => this.loginButton = true);
    
    else setState(() => this.loginButton = false);
  }

  void login() {
    UserManagementService.login(User(this.usernameController.text, this.passwordController.text)).then((response) async {
      dynamic responseData = jsonDecode(response.body);

      if(responseData["message"] == "Password is wrong" || responseData["message"] == "User not found")
        showDialog(context: context, builder: (context){
          
          return AlertDialog(
            title: Text("Error"),
            content: Text(responseData["message"]),
            actions: [
              ElevatedButton(
                onPressed: Navigator.of(context).pop, 
                child: Text("OK"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193))
                )
              )
            ],
          );
        });


        
      else {
        DirectoryHelper.setUserData(responseData);
        Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardPage()));
      }


    });
  }
  

  void reset(){
    setState(() {
      this.usernameController.text = "";
      this.passwordController.text = "";
    });
  }


  void back(BuildContext context){
    Navigator.pop(context);
  }


}