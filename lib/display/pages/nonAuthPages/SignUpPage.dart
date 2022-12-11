import 'dart:convert';

import 'package:anon_chat_mobile_app/models/User.dart';
import 'package:flutter/material.dart';

import '../../../services/UserManagementService.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool signUpButton = false;



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
        margin: EdgeInsets.only(top: 50),
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
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
              ),
              controller: usernameController,
              onChanged: (text){this.activateSignUp();},
            ),
    
    
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter password",
              ),
              controller: passwordController, 
              onChanged: (text){this.activateSignUp();},
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
    
    
                child: Text("Sign Up"),
                onPressed: this.signUpButton ?  () => this.signUp() : null
              )
            ),
    
            Text("   "),
    
    
            SizedBox(
              width: double.infinity,
              height: 30,
              child:  ElevatedButton(
                
                style: ButtonStyle(
                  foregroundColor:  MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)), 
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 199, 0, 0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))
                  )
                ),
    
                child: Text("Reset"),
                onPressed: this.reset
              )
            ),
    
    
            Text("   "),
    
            
    
    
          ],
        )
      ),
    );
  }

  bool formIsValid(){
    return this.usernameController.text != "" && this.passwordController.text != "";
  }


  void activateSignUp(){
    setState(() {
      this.signUpButton = this.formIsValid(); 
    });

  }

  void signUp(){
   UserManagementService.signUp(User(
      this.usernameController.text,
      this.passwordController.text
      
    )).then((response) {
      dynamic responseData = jsonDecode(response.body);


      showDialog(context: context, builder: (context){
        
        return AlertDialog(
          title: Text(responseData["message"]),
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