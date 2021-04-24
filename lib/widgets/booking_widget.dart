import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Table\'s number'
            ),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Time'
            ),
          ),
        ],
      ),
    );
  }
}
