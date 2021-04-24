import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Tables {
  String id;
  int num;
  int capacity;
  List<bool> schedule = [];
  /*bool firstHour;
  bool secondHour;
  bool thirdHour;
  bool forthHour;
  bool fifthHour;
  bool sixthHour;
  bool seventhHour ;
  bool eighthHour;
*/
  Tables({
    @required this.id,
    @required this.num,
    @required this.capacity,
    @required this.schedule,
    /*@required this.firstHour,
    @required this.secondHour,
    @required this.thirdHour,
    @required this.forthHour,
    @required this.fifthHour,
    @required this.sixthHour,
    @required this.seventhHour,
    @required this.eighthHour,*/
  });
}
