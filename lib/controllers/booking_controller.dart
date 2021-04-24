import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traktir_davl/widgets/booking_widget.dart';
import 'package:http/http.dart' as http;

import 'tables_controller.dart';
import '../models/tables.dart';

class BookingController extends GetxController {
  
  void book(BuildContext context){
    showModalBottomSheet(context: context, builder: (_) {
      return Booking();
    },);
  }

  Future<void> test(Tables table) async {


    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables/${table.id}.json';
    var response = await http.patch(url, body: jsonEncode({
      'third_hour': table.schedule[2],
    }));

  }
  
}