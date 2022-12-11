import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/ChatRoomPage.dart';
import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/CreateRoomPage.dart';
import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/SearchRoomPage.dart';
import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/SettingsPage.dart';
import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/SubscribedRoomListPage.dart';
import 'package:flutter/material.dart';


class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  int _currentIndex = 0;
  Widget currentPage = SearchRoomPage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 8, 221, 193),
        fixedColor: Colors.white,
        currentIndex: this._currentIndex,
        type: BottomNavigationBarType.fixed,
        items: addNavbarItem(),
        onTap: (index) {
          setCurrentIndex(index);
          changePage(index);
        },
      ),

    );
  }


  void setCurrentIndex(int index) {
    setState(() => this._currentIndex = index);
  }


  void changePage(int index){
    switch(index){

      case 0: 
        this.searchRoomPage();
        return;
      
      case 1: 
        this.subscribedRooms();
        return;
     
      case 2: 
        this.createChatRoom();
        return;
      
      case 3: 
        this.accountSettings();
        return;

    }
  }


  List<BottomNavigationBarItem> addNavbarItem(){
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];


      return [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search chat room"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "subscribed rooms"),
        BottomNavigationBarItem(icon: Icon(Icons.create), label: "Create chat room"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ];
  }


  


  void searchRoomPage(){
    setState(() => this.currentPage = SearchRoomPage());
  }

  void subscribedRooms(){
    setState(() => this.currentPage = SubscribeRoomListPage());
  }

  void createChatRoom(){
    setState(() => this.currentPage = CreateRoomPage());
  }

  void accountSettings(){
    setState(() => this.currentPage = SettingsPage());
  }


}



