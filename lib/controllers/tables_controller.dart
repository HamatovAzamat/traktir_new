import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/tables.dart';

class TablesController extends GetxController {

  var loadedTables = List<Tables>().obs;

  static const Map<int, String> scheduleMap = {
    0: 'first_hour',
    1: 'second_hour',
    2: 'third_hour',
    3: 'fourth_hour',
    4: 'fifth_hour',
    5: 'sixth_hour',
    6: 'seventh_hour',
    7: 'eighth_hour',
  };

  void clear() {
    loadedTables.clear();
  }

  Future<void> updateTables(String token) async {

    var updatedTables = List<Tables>().obs;
    updatedTables.clear();
    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables.json?auth=$token';
    try {
      final response = await http.get(url);
      final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
      int i = 0;
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
        loadedTables.insert(i, Tables(
          id: id,
          num: tablesData['num'],
          capacity: tablesData['capacity'],
          schedule: tempSchedule,
        ));
        i++;
        //loadedTables = updatedTables;
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> getAllTables(String token) async {
    final url = 'https://traktirdav-default-rtdb.firebaseio.com/tables.json?auth=$token';
    var map = Map<String, dynamic>();
    try {
      final response = await http.get(url);
      final decodedResponse =
          json.decode(response.body) as Map<String, dynamic>;
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
        loadedTables.add(
          Tables(
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
    } catch (error) {
      throw error;
    }
  }

  Future<void> patchTables(int table, int hour, String token) async {
    String str_hour;

    for (int i in scheduleMap.keys) {
      if (i == hour) {
        str_hour = scheduleMap[i];
        break;
      }
    }

    final url =
        'https://traktirdav-default-rtdb.firebaseio.com/tables/${loadedTables[table].id}.json?auth=$token';
    var response = await http.patch(url,
        body: jsonEncode({
          str_hour: loadedTables[table].schedule[hour],
        }));
  }
}
