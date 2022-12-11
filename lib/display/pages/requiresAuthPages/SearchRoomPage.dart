import 'dart:convert';

import 'package:anon_chat_mobile_app/helpers/DirectoryHelper.dart';
import 'package:anon_chat_mobile_app/services/ChatRoomManagementService.dart';
import 'package:flutter/material.dart';

import '../../../models/Room.dart';


class SearchRoomPage extends StatefulWidget {
  const SearchRoomPage({super.key});

  @override
  State<SearchRoomPage> createState() => _SearchRoomPageState();
}

class _SearchRoomPageState extends State<SearchRoomPage> {
  final TextEditingController chatRoomNameController = TextEditingController();

  late List<Room> rooms = [];
  late List<ListTile> displayedRooms = [];

  final TextEditingController roomNameController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getRooms();
  }


  @override
  Widget build(BuildContext context) {

    return Container(

      padding: EdgeInsets.all(20),

      child: Column(
        children: [

          TextField(
            decoration: InputDecoration(
              hintText: "Room name",
              icon: Icon(Icons.search, color: Color.fromARGB(255, 8, 221, 193)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
            ),
            controller: roomNameController,
            onChanged: (value) => this.searchRoom(),
          ),

          Text("    "), 

          Expanded(child: 
            SizedBox(
              height: 50,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(color: Colors.black, endIndent: 16, indent: 16),
                itemCount: this.displayedRooms.length,
                itemBuilder: (context, index) => this.displayedRooms[index],
              )
            )
          )

        ],
      ),
    );



  }



  void getRooms() async {
    
    ChatRoomManagementService.getRooms(await DirectoryHelper.getToken()).then((response) {
      dynamic responseData = jsonDecode(response.body);


      for(dynamic responseElement in responseData)
        setState(() => this.rooms.add(Room.createRoomInstance(int.parse(responseElement["id"]), responseElement["name"], responseElement["type"])));
      

      this.displayedRooms = this.listRooms();
      
    });
  }


  List<ListTile> listRooms(){

    List<ListTile> rooms = [];

    for(int i = 0; i < this.rooms.length; i++)
      rooms.add(
        ListTile(
          leading: Text(this.rooms[i].getName()),
          trailing: ElevatedButton(
            child: Text("Details"),

            style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193))
            ), 

            onPressed: ()  {
              
              showDialog(context: context, builder: (context){
          
                return SimpleDialog(
                  title: Text("Recycle Request Details", textAlign: TextAlign.center),
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(children: [Text("id: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getId().toString())]),
                          Row(children: [Text("name: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getName())]),
                          Row(children: [Text("type: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getType())]),
                        ],
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 60),
                      child: Row(
                        children: [
                          ElevatedButton( onPressed: () => joinRoom(this.rooms[i]), child: Text("Join"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193)))),
                          Text("       "),
                          ElevatedButton( onPressed: Navigator.of(context).pop, child: Text("Quit"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 187, 31, 20))))

                        ],
                      )
                    )
                  ]
                );
              });


            }
          ),
        ),
      );


    return rooms;

  }



  void joinRoom(Room room) async{

    ChatRoomManagementService.joinChatRoom(room, await DirectoryHelper.getToken()).then((response) {
      dynamic responseData = jsonDecode(response.body);

      Navigator.of(context).pop();
      
      showDialog(context: context, builder: (context){
          
          return AlertDialog(
            title: Text("Success"),
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


  void searchRoom(){

    if(this.roomNameController.text == ""){
      this.rooms = [];
      this.getRooms();
      
    }else { 

      List<Room> rooms = [];

      for(Room room in this.rooms)
        if(room.getName().toLowerCase().contains(this.roomNameController.text.toLowerCase()))
          rooms.add(room);
      

      
      setState(() {
        this.rooms = rooms;
        this.displayedRooms = this.listRooms();
      });

    }

  }




}