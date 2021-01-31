import 'package:INGSW_MezMar/models/users_singleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tabs.dart';
import '../models/auth.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String username;

  @override
  void initState() {
    username = UsersSingleton.instance.username;
    super.initState();
  }

  @override
  Widget build(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        username,
                        style: TextStyle(
                            fontFamily: 'poppins-regular',
                            fontSize: 25.0,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.lock_open),
            onTap: () {
              Provider.of<Auth>(context).logout();
              Navigator.pop(context);
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
