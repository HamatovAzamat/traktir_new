import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traktir_davl/screens/auth_screen.dart';
import 'package:traktir_davl/screens/booking_screen.dart';
import 'package:traktir_davl/widgets/app_drawer.dart';

import 'screens/information_screen.dart';
import 'screens/introduction_screen.dart';
import 'screens/splash_screen.dart';
import 'controllers/auth_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuth = false;
  final authController = Get.put(AuthController());

  @override
  void initState() {
    appBarTitle = _screenTitle[0];
    super.initState();
  }

  List<Widget> _screens = [
    IntroductionScreen(),
    BookingScreen(),
    InformationScreen()
  ];
  List<String> _screenTitle = [
    'Главная',
    'Расписание',
    'Информация',
  ];

  int _selectedPageIndex = 0;
  String appBarTitle;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      appBarTitle = _screenTitle[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traktir Dvl',
      home: GetBuilder(
        init: AuthController(),
        builder: (authController) {
          return (!authController.checkAuth)
              ? FutureBuilder(future: authController.tryAutoLogin(), builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen())
              : Scaffold(
                  drawer: AppDrawer(),
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    title: Text(
                      appBarTitle,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  body: _screens[_selectedPageIndex],
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.white, width: 3.0)),
                    ),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.black,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.grey[800],
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: _screenTitle[0],
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.article_outlined),
                          label: _screenTitle[1],
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.info_outline),
                          label: _screenTitle[2],
                        ),
                      ],
                      onTap: _selectPage,
                      currentIndex: _selectedPageIndex,
                    ),
                  ),
              );
        },
      ),
    );
  }
}
