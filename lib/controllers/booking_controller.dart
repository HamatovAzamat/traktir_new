import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/booking_widget.dart';


class BookingController extends GetxController {

  void book(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BookingWidget();
      },
    );
  }
}
