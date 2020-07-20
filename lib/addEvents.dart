import 'package:flutter/material.dart';
import 'package:get_events/main.dart';
import 'package:multi_date_range_picker/multi_date_range_picker.dart';
// import 'dart:developer';


class MyAppPage extends StatefulWidget {
  const MyAppPage({Key key}) : super(key: key);

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {

  TextEditingController addEventController = TextEditingController();
  List<List<DateTime>> intervals = [];
  
  eventSubmit(){
 
    List<DateTime> arrayOfDates = [];
    for (int i = 0; i <= intervals[0][1].difference(intervals[0][0]).inDays; i++) {
      arrayOfDates.add(intervals[0][0].add(Duration(days: i)));
    }

    
    eventsRef.add({
      "eventName": addEventController.text,
      "eventDates": arrayOfDates,
    }).then((value) => Navigator.pop(context));

    
  }

  @override
  Widget build(BuildContext context) {
    print("dd");
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Event'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                
                Text("Select Date Range", style:TextStyle(fontSize: 16)),

                MultiDateRangePicker(
                  initialValue: intervals,
                  onChanged: (List<List<DateTime>> intervals) {
                    setState(() {
                      this.intervals = intervals;
                    });
                  },
                  selectionColor: Colors.lightBlueAccent,
                  buttonColor: Colors.lightBlueAccent,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16.0),
                          child: Column(
                            children: buildColumn(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                      BoxShadow(
                      color: Colors.blue,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      )
                     ],
                    ),
                    child: TextField(
                    controller: addEventController,
                    
                    decoration: InputDecoration(
                    hintText: "Add Event Name",
                    border: InputBorder.none,
                    
                  ),
                  ),
                  ),
                  SizedBox(height:40),
                  Container(
                  width: 150,
                  height:50,
                  
                 child: FlatButton(
                    onPressed: ()=>{
                    eventSubmit()
                    },
                    color: Colors.blue[300],
                    child: Text("Submit",style: TextStyle(fontSize: 18,color: Colors.white),)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildColumn() {
    final List<Widget> list = [];

    for (final interval in intervals) {
      list.add(Text(interval[0].toString() + " - " + interval[1].toString()));
      if (interval != intervals.last)
        list.add(SizedBox(
          height: 8,
        ));
    }

    return list;
  }
}