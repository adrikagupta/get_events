import 'package:cloud_firestore/cloud_firestore.dart';



final events = Firestore.instance.collection('events');


class DateEvent{
  final String eventName;
  final Timestamp startDate;
  final Timestamp endDate;

  DateEvent({this.eventName, this.startDate,this.endDate});

  factory DateEvent.fromDocument(DocumentSnapshot doc){
    return DateEvent( eventName: doc['eventName'],
    startDate: doc['eventStartDate'],
    endDate: doc['eventEndDate'],
    );
  }

}