import 'package:INGSW_MezMar/home_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'home.dart';
import 'saved.dart';
import 'to_be_seen.dart';
import 'partials/drawer.dart';
import 'package:provider/provider.dart';
import 'models/tabs.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _width;
  double _height;
  Widget screen(){
    if(Provider.of<Tabs>(context).currentIndex == 0) {
      return Home();
    }
    else if(Provider.of<Tabs>(context).currentIndex== 1) {
      return ToBeSeen();
    }
    else if(Provider.of<Tabs>(context).currentIndex == 2) {
      return Saved();
    }

    else if(Provider.of<Tabs>(context).currentIndex == 3) {
      return HomeUsers();
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
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: Provider.of<Tabs>(context).currentIndex,
        onItemSelected: (index) => setState(() {
          Provider.of<Tabs>(context).changeIndex(index);
        }),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.movie),
              title: Text('FILM'),
              activeColor: Colors.teal,
              inactiveColor: Colors.black54
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.remove_red_eye),
              title: Text('DA VEDERE'),
              activeColor: Colors.teal,
              inactiveColor: Colors.black54
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text('PREFERITI'),
              activeColor: Colors.teal,
              inactiveColor: Colors.black54
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              title: Text('UTENTI'),
              activeColor: Colors.teal,
              inactiveColor: Colors.black54
          ),
        ],
      ),
    );
  }

}
