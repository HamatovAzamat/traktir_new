import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/tables_controller.dart';
import '../controllers/auth_controller.dart';
import '../screens/main_screen.dart';

class BookingWidget extends StatefulWidget {
  @override
  _BookingWidgetState createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  final tablesController = Get.put(TablesController());
  final authController = Get.put(AuthController());
  final tableController = TextEditingController();
  final hourController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : Container(
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
                    //hintText: 'Номер строки с нужным временем',
                  ),
                ),
                RaisedButton(
                  child: Text('Book'),
                  onPressed: () {
                    int tableNumber = int.parse(tableController.text);
                    int hourNumber = int.parse(hourController.text);

                    tablesController.updateTables(authController.token).then((value) {
                      print(tablesController.loadedTables[tableNumber - 1]
                          .schedule[hourNumber - 1]);
                      if (tablesController.loadedTables[tableNumber - 1]
                          .schedule[hourNumber - 1]) {
                        print('if statement goes well');
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('Error!'),
                            content: Text(
                                  'This table has already been booked! Please, pick the other one!'
                            ),
                            actions: [
                              RaisedButton(
                                child: Text('Back'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        tablesController.loadedTables[tableNumber - 1]
                                .schedule[hourNumber - 1] =
                            !tablesController.loadedTables[tableNumber - 1]
                                .schedule[hourNumber - 1];
                        try {
                          tablesController.patchTables(
                              tableNumber - 1, hourNumber - 1, authController.token);
                          _isLoading = false;
                        } catch (e) {
                          print(e.toString());
                          Navigator.of(context).pop();
                        }
                        Navigator.of(context).pop();
                      }
                    });
                  },
                )
              ],
            ),
          );
  }
}
