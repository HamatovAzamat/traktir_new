import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/booking_controller.dart';
import '../controllers/tables_controller.dart';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final bookingController = Get.put(BookingController());


  @override
  Widget build(BuildContext context) {
  }
}
