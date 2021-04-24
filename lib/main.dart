import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traktir_davl/controllers/tables_controller.dart';
import 'package:traktir_davl/screens/main_screen.dart';

import './widgets/bnb.dart';
import './models/tables.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Traktir Dvl',
      home: MainScreen(),
    );
  }
}
