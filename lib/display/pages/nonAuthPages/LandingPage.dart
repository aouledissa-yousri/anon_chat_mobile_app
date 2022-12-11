import 'package:anon_chat_mobile_app/display/pages/nonAuthPages/LoginPage.dart';
import 'package:anon_chat_mobile_app/display/pages/nonAuthPages/SignUpPage.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 24, 248, 110),
              Color.fromARGB(255, 63, 248, 177)
            ]
          )
        ),
    
        child: Container(
          child: Column(
            children: [
    
                 
              Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
                "Welcome to Anon-chat"
              ),
    
              Container(margin: EdgeInsets.only(bottom: 350),),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextButton(
                      onPressed: () => goToLoginPage(context),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
    
                      
                    ),
                  ),
    
                  Text("    "),
    
                  Container(
                    height: 50,
                    width: 120,
    
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)
                    ),
    
                    child: TextButton(
                      onPressed: () => goToSignUpPage(context), 
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                      
    
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }





  void goToLoginPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void goToSignUpPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }



}
