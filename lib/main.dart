import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get_events/eventsList.dart';
import 'package:get_events/getEvents.dart';
import 'package:intl/intl.dart';

final eventsRef = Firestore.instance.collection('events');
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    QuerySnapshot snapshot = await eventsRef.getDocuments();
    List allEvents=[];
    List dateEvents=[];
    snapshot.documents.forEach((doc) {
      allEvents.add(DateEvent.fromDocument(doc));
     });
     allEvents.forEach((eve) { 
       DateTime startdateTime = eve.startDate.toDate();
       DateTime enddateTime = eve.endDate.toDate();
       String formattedStartDate = DateFormat('yyyy-MM-dd').format(startdateTime);
       String formattedEndDate = DateFormat('yyyy-MM-dd').format(enddateTime);
       String formattedSelectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    
       if((startdateTime.isBefore(_selectedDate)&& enddateTime.isAfter(_selectedDate))|| formattedStartDate==formattedSelectedDate)
       dateEvents.add(eve);
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

