import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/tables.dart';


class TablesController extends GetxController{

  var loadedTables = List<Tables>().obs;

  void clearAll(){
    loadedTables.clear();
  }

  Future<void> getAllTables() async {
    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables.json';
    var map = Map<String, dynamic>();
    try {
      final response = await http.get(url);
      final decodedResponse = json.decode(response.body) as Map<String, dynamic>;

      decodedResponse.forEach((id, tablesData) {
        List<bool> tempSchedule = [];
        tempSchedule.add(tablesData['first_hour']);
        tempSchedule.add(tablesData['second_hour']);
        tempSchedule.add(tablesData['third_hour']);
        tempSchedule.add(tablesData['forth_hour']);
        tempSchedule.add(tablesData['fifth_hour']);
        tempSchedule.add(tablesData['sixth_hour']);
        tempSchedule.add(tablesData['seventh_hour']);
        tempSchedule.add(tablesData['eighth_hour']);
        loadedTables.add(Tables(
          id: id,
          num: tablesData['num'],
          capacity: tablesData['capacity'],
          schedule: tempSchedule,
        ),
        );
      });
      //loadedTables = rawTables;
      /*for (int i = 0; i < loadedTables.length; i++) {
        print('$i tables id is ${loadedTables[i].id}');
      }*/
    }
    catch (error){
      throw error;
    }
  }


  Future<void> patchTables(int table, int hour) async {
    String str_hour;
    Map<int, String> scheduleMap = {
      1: 'first_hour',
      2: 'second_hour',
      3: 'third_hour',
      4: 'fourth_hour',
      5: 'fifth_hour',
      6: 'sixth_hour',
      7: 'seventh_hour',
      8: 'eighth_hour',
    };

    for (int i in scheduleMap.keys) {
      if (i == hour) {
        str_hour = scheduleMap[i];
        print(str_hour);
        print(table.toString());
        break;
      }
    }

    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables/${loadedTables[table +
        1].id}.json';
    var response = await http.patch(url, body: jsonEncode({
      str_hour: loadedTables[table + 1].schedule[hour],
    }));
  }


  }