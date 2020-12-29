import 'package:flutter/material.dart';
import 'models/tabs.dart';
import 'package:provider/provider.dart';
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
          Provider.of<Tabs>(context).changeIndex(0);
        },),
        title: Text('Richieste di collegamento',style: TextStyle(fontFamily: 'poppins-regular',fontWeight: FontWeight.w500),),
      ),
      body: ListView(
        children: <Widget>[
          itemCard(false),
          itemCard(false),
          itemCard(false),
          itemCard(false),
        ],
      ),
    );
  }
}




Widget itemCard( bool isConnected) {
  Stack(children: [

  ],);
  return Padding(
    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
    child: Container(

      height: 163.0,
      width: double.infinity,
      //color: Colors.white,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5.0),
                  Container(
                    width: 375,
                    child: Text(
                      'Nickname',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontSize: 20.0),
                    ),
                  ),
                  Container(
                    width: 375,
                    child: Text(
                      'Nome e cognome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 16.0),
                    ),
                  ),

                ],
              ),
              
              Container(

                width: 375.0,
                child: FlatButton(
                  color: Colors.teal,
                  onPressed: (){},
                  textColor: Colors.white,
                  child: Center(
                    child: Text(
                      'ACCETTA',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
              Container(
                width: 375.0,
                child: FlatButton(
                  color: Colors.redAccent,
                  onPressed: (){},
                  textColor: Colors.white,
                  child: Center(
                    child: Text(
                      'RIFIUTA',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
              ),


            ],
          )
        ],
      ),
    ),
  );
}




