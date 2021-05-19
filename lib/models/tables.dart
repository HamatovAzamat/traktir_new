import 'package:flutter/foundation.dart';

class Tables {
  String id;
  int num;
  int capacity;
  List<bool> schedule = [];

  Tables({
    @required this.id,
    @required this.num,
    @required this.capacity,
    @required this.schedule,
  });
}
