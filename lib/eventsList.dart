
import 'package:flutter/material.dart';


class EventsList extends StatelessWidget {
 final List dateEvents;
  EventsList({this.dateEvents});

  

  @override
  Widget build(BuildContext context) {
  
   List<Widget> finalEvents=[];
   
   dateEvents.forEach((event){
     print(event.eventDates);
    var len = event.eventDates.length -1;
   finalEvents.add(Container(
     decoration: BoxDecoration(
       color: Colors.red,
       borderRadius: BorderRadius.circular(20),
     ),
     padding:EdgeInsets.all(10),
     margin:EdgeInsets.fromLTRB(10,15,10,0),
     height:120,
     child:Column(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: <Widget>[
         Text("${event.eventName}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)),),
         SizedBox(height:5),
         Text("Start DateTime: ${event.eventDates[0].toDate()}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.white)),
         Text("End DateTime: ${event.eventDates[len].toDate()}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.white)),
      
         
       ],
     ),
   ));
  });
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(
        title: Text("Your Events", style: TextStyle(fontSize: 27),),
        centerTitle: true,
        backgroundColor: Colors.red,
        ),
        body: ListView(
          children: finalEvents,
        )
      ),
    );
  }
}