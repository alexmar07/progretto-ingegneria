import 'package:flutter/material.dart';
import 'package:INGSW_MezMar/login.dart';
import 'package:provider/provider.dart';
import '../models/tabs.dart';
import '../models/auth.dart';
class AppDrawerVisitor extends StatelessWidget {
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
                        'Ciao, Visitatore',
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
            title: Text('Accedi o Registrati'),
            leading: Icon(Icons.face),
            onTap: () {

              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: ( context) =>LoginPage(),
                    fullscreenDialog: true),
              );
            },
          ),

          Divider()
        ],
      ),
    );
  }
}
