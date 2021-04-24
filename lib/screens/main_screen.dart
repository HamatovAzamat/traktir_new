import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tables_controller.dart';
import '../widgets/schedule_widget.dart';
import '../controllers/booking_controller.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = false;
  final TablesController tablesController = Get.put(TablesController());
  final BookingController bookingController = Get.put(BookingController());

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    tablesController
        .getAllTables()
        .then((value) => setState(() {
              _isLoading = false;
            }))
        .catchError((error) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occured'),
                content: Text(error.toString()),
                actions: [
                  RaisedButton(
                    child: Text('Выйти'),
                    onPressed: () {
                      Get.to(MainScreen());
                      _isLoading = false;
                    },
                  ),
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Главная',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => tablesController.getAllTables(),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 290,
                    alignment: Alignment.topCenter,
                    child: ListView.separated(
                      addAutomaticKeepAlives: false,
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          width: 5,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (ctx, i) {
                        return Card(
                          shadowColor: Colors.white,
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text('${i + 1} tables schedule'),
                                ScheduleTable(i),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    RaisedButton(
                      child: Text('Update'),
                      onPressed: () {
                        tablesController.clearAll();
                        initState();
                      },
                    ),
                    RaisedButton(
                      child: Text('Book a table'),
                      onPressed: () {
                        tablesController.loadedTables[3].schedule[2] = !tablesController.loadedTables[3].schedule[2];
                        bookingController.test(tablesController.loadedTables[3],);
                      },
                    ),
                  ]),
                ],
              ),
      ),
    );
  }
}
