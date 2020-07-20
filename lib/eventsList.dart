
import 'package:flutter/material.dart';


class EventsList extends StatelessWidget {
 final List dateEvents;
  EventsList({this.dateEvents});

  

  @override
  Widget build(BuildContext context) {
  

  Widget buildEventsList(BuildContext cxt, int index){
      var len = dateEvents[index].eventDates.length -1;
    return Container(
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
         Text("${dateEvents[index].eventName}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8)),),
         SizedBox(height:5),
         Text("Start DateTime: ${dateEvents[index].eventDates[0].toDate()}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.white)),
         Text("End DateTime: ${dateEvents[index].eventDates[len].toDate()}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500, color: Colors.white)),
      
         
       ],
     ),
   );

  }
    return SafeArea(
      child:Scaffold(
        appBar: AppBar(
        title: Text("Your Events", style: TextStyle(fontSize: 27),),
        centerTitle: true,
        backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          itemCount: dateEvents.length,
          itemBuilder: (BuildContext cxt, int index){
            return buildEventsList(cxt,index);
          },
        )
      ),
    );
  }
}