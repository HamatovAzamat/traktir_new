import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'tables_controller.dart';
import '../models/tables.dart';

class BookingController extends GetxController {

  final tablesController = Get.put(TablesController());
  
  void book(BuildContext context){

    final tableController = TextEditingController();
    final hourController = TextEditingController();

    showModalBottomSheet(context: context, builder: (_) {
      return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Table\'s number',
              ),
              controller: tableController,
              maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
              maxLength: 1,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: hourController,
              decoration: InputDecoration(
                labelText: 'Set time',
                hintText: 'Номер строки с нужным временем',
              ),
            ),
            RaisedButton(
                child: Text('Book'),
                onPressed:(){
                  int tableNumber = int.parse(tableController.text);
                  int hourNumber = int.parse(hourController.text);
                  tablesController.loadedTables[tableNumber].schedule[hourNumber] = !tablesController.loadedTables[tableNumber].schedule[hourNumber];
                  try{
                    patchTables(tableNumber, hourNumber);
                  }
                  catch(e){
                    Navigator.pop(context);
                    print(e.toString());
                  }
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      );;
    },);
  }

  Future<void> patchTables(int table, int hour) async {

    String str_hour;
    Map<int, String> scheduleMap = {
      1:'first_hour',
      2:'second_hour',
      3:'third_hour',
      4:'fourth_hour',
      5:'fifth_hour',
      6:'sixth_hour',
      7:'seventh_hour',
      8:'eighth_hour',
    };

    for (int i in scheduleMap.keys){
      if(i == hour) {
        str_hour = scheduleMap[i];
        print(str_hour);
        print(table.toString());
        break;
      }
    }

    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables/${tablesController.loadedTables[table + 1].id}.json';
    var response = await http.patch(url, body: jsonEncode({
      str_hour: tablesController.loadedTables[table + 1].schedule[hour],
    }));

  }
  
}