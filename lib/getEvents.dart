import 'package:cloud_firestore/cloud_firestore.dart';



final events = Firestore.instance.collection('events');


class DateEvent{
  final String eventName;
  final List eventDates;


  DateEvent({this.eventName, this.eventDates});

  factory DateEvent.fromDocument(DocumentSnapshot doc){
    return DateEvent( eventName: doc['eventName'],
    eventDates: doc['eventDates'],
    
    );
  }

}