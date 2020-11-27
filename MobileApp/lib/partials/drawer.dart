import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../change_details.dart';
import '../models/tabs.dart';
import '../models/auth.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build( context) {
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
                        'Pascal Mazing',
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

          Divider(),
          ListTile(
            title: Text('Modifica Profilo'),
            leading: Icon(Icons.face),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: ( context) => ChangeDetails(),
                    fullscreenDialog: true),
              );
            },
          ),

          Divider(),
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
