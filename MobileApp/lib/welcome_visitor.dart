import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:INGSW_MezMar/change_details.dart';
import 'package:INGSW_MezMar/home_visitor.dart';
import 'package:INGSW_MezMar/partials/drawer_visitor.dart';
import 'home_movies.dart';

import 'home_visitor.dart';
import 'partials/drawer.dart';
import 'package:provider/provider.dart';
import 'models/tabs.dart';
class WelcomeVisitorScreen extends StatefulWidget {
  @override
  _WelcomeVisitorScreenState createState() => _WelcomeVisitorScreenState();
}

class _WelcomeVisitorScreenState extends State<WelcomeVisitorScreen> {
  double _width;
  double _height;
  Widget screen(){
    if(Provider.of<Tabs>(context).currentIndex == 0) {
      return HomeVisitor();
    }

  }

  @override
  Widget build(BuildContext context) {


    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.teal,
        //or set color with: Color(0xFF0000FF)
        statusBarBrightness: Brightness.light));
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: screen(),
      drawer: AppDrawerVisitor(),
    );
  }

}
