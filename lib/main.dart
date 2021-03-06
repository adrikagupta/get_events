import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get_events/addEvents.dart';
import 'package:get_events/eventsList.dart';
import 'package:get_events/getEvents.dart';


final eventsRef = Firestore.instance.collection('events');
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    DateTime _selectedDate;

  

  getInfo() async{
    QuerySnapshot snapshot = await eventsRef.where("eventDates", arrayContains:Timestamp.fromDate(_selectedDate)).getDocuments();
    List dateEvents=[];
    snapshot.documents.forEach((doc) {
      dateEvents.add(DateEvent.fromDocument(doc));
     });
     if(dateEvents.isEmpty)
     {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text("No events registered!")));
     }
     else
     Navigator.push(context, MaterialPageRoute(builder: (context)=>EventsList(dateEvents: dateEvents)));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Get your Events!", style: TextStyle(fontSize: 27),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child:Center(
          child: Container(
            height: 370,
            width: 380,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 250,
                  height:50,
                  child: FlatButton(
                    onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAppPage()))
                    },
                    color: Colors.white,
                    child: Text("Add Events",style: TextStyle(fontSize: 18),)
                  ),
                ),
                Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
              looping: false,   // default is not looping
              firstDate: DateTime(2017),
              lastDate: DateTime(2020, 12, 31),
              initialDate: DateTime(2015),
              dateFormat: "dd-MMMM-yyyy",
              onChange: (DateTime newDate, _) => _selectedDate = newDate,
              pickerTheme: DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19)),
              ),
              ),

            
                Container(
                  width: 250,
                  height:50,
                  child: FlatButton(
                    onPressed: ()=>{
                      getInfo()
                    },
                    color: Colors.white,
                    child: Text("Get Events",style: TextStyle(fontSize: 18),)
                  ),
                ),
              ],
            ),
          ),
          
        ),
      ),
    );
  }
}

