import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traktir_davl/controllers/tables_controller.dart';
import 'package:flutter/foundation.dart';

class ScheduleTable extends StatefulWidget {
  final int index;

  ScheduleTable(this.index);

  @override
  _ScheduleTableState createState() => _ScheduleTableState();
}


class _ScheduleTableState extends State<ScheduleTable> {
  List<TableRow> tableRows = [];

  TablesController tc = Get.put(TablesController());

  _ScheduleTableState() {
    //createTableRows();
  }

  @override
  void initState() {
    //createTableRows();
    super.initState();
  }

  void createTableRows(){
    int currentHour = 18;
    for (int i = 0; i < 8; i++) {
      if (currentHour >= 24) {
        currentHour = currentHour - 24;
      }
      tableRows.add(
        new TableRow(
          children: <Widget>[
            Container(
              child: Text('${i+1}'),
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
            ),
            Container(
              child: Text('$currentHour:00 - ${currentHour + 1}:00'),
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
            ),
            Container(
              child: Obx(() =>
                  Text(
                    (tc.loadedTables[widget.index].schedule[i]) ? 'Booked!' : 'Free!',
                    textAlign: TextAlign.center,
                  ),
              ),

              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
            ),
          ],
        ),
      );
      currentHour++;
    }
  }


  @override
  Widget build(BuildContext context) {

    int i = 1;

    tableRows = [];
    createTableRows();
    return Container(
      padding: EdgeInsets.all(15),
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: IntrinsicColumnWidth(),
          2: IntrinsicColumnWidth(),
          3: IntrinsicColumnWidth(),
        },
        children: tableRows,
      ),
    );
  }
}
