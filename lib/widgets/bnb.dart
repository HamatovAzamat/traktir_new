import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBottomNavigationBar extends StatefulWidget {

  int index;

  NewBottomNavigationBar(this.index);

  @override
  _NewBottomNavigationBarState createState() => _NewBottomNavigationBarState();
}

class _NewBottomNavigationBarState extends State<NewBottomNavigationBar> {

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Main',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_location_rounded),
          label: 'Location',
        ),
      ],
    );
  }
}
