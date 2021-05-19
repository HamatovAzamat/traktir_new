import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(''),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              authController.logout();
            },
          )
        ],
      ),
    );
  }
}
