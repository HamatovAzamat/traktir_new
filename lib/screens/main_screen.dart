import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traktir_davl/controllers/auth_controller.dart';

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
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    tablesController
        .getAllTables(authController.token)
        .then((value) => setState(() {
              _isLoading = false;
            }))
        .catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Some table'),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
          onRefresh: () => tablesController.getAllTables(authController.token),
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
                      child: PageView.builder(
                        allowImplicitScrolling: true,
                        /*addAutomaticKeepAlives: false,
                        separatorBuilder: (context, i) {
                          return SizedBox(
                            width: 5,
                          );
                        },*/
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
                              setState(() {
                                _isLoading = true;
                              });
                              tablesController.updateTables(authController.token).then((value) => setState(() {
                                _isLoading = false;
                              })
                              );
                            },
                          ),
                          RaisedButton(
                            child: Text('Book a table'),
                            onPressed: () {
                              bookingController.book(context);
                            },
                          ),
                        ]),

                  ],

                ),
        ),
    );
  }
}
