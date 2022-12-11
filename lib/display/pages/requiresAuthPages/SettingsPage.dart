

import 'package:flutter/material.dart';

import '../../../helpers/DirectoryHelper.dart';
import '../../../services/UserManagementService.dart';
import '../nonAuthPages/LandingPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late Map<String, dynamic> userData = Map<String, dynamic>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.loadUserData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: this.userData.isEmpty? Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 8, 221, 193))) :
        ListView(
          children: [
            Text(userData["username"], textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
            Text("  \n   "),
            ListTile(
              leading: Text("Log out"),
              trailing: IconButton(
                  icon: Icon(Icons.logout, color: Color.fromARGB(255, 8, 221, 193)),
                  onPressed: () => logout()
                ),
            ),

            Divider(color: Color.fromARGB(255, 39, 39, 39), endIndent: 16, indent: 16),


          ],
        )
    );
  }


  Future<void> loadUserData() async{
    dynamic userData = await DirectoryHelper.getUserData();
    setState(() { this.userData = userData; });
  }


  logout(){
    UserManagementService.logout(userData["token"]);
    DirectoryHelper.deleteUserData();
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
  }

}