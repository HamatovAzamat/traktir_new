import 'package:flutter/material.dart';
import 'package:traktir_davl/widgets/room_widget.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight / 2,
      width: double.infinity,
      child: PageView(
        children: [
          RoomWidget(),
          RoomWidget(),
        ],
      ),
    );
  }
}
