import 'package:flutter/material.dart';
import 'models/tabs.dart';
import 'package:provider/provider.dart';
class ToBeSeen extends StatefulWidget {
  @override
  _ToBeSeenState createState() => _ToBeSeenState();
}

class _ToBeSeenState extends State<ToBeSeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.arrow_back),onTap: (){
          Provider.of<Tabs>(context).changeIndex(0);
        },),
        title: Text('Lista di film da vedere',style: TextStyle(fontFamily: 'poppins-regular',fontWeight: FontWeight.w500),),
      ),
      body: ListView(
        children: <Widget>[
          itemCard('FILM','assets/images/joker.jpg',false),
          itemCard('FILM','assets/images/miglio.jpg',false),
        ],
      ),
    );
  }
}




Widget itemCard(String title, String imgPath, bool isFavorite) {
  return Padding(
    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
    child: Container(

      height: 120.0,
      width: double.infinity,
      //color: Colors.white,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 140.0,
            height: 160.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                image: DecorationImage(

                    image: AssetImage(imgPath), fit: BoxFit.cover)),
          ),
          SizedBox(width: 4.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 17.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    width: 175.0,
                    child: Text(
                      'Genere',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 12.0),
                    ),
                  ),
                  Container(
                    width: 175.0,
                    child: Text(
                      'Anno di uscita',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.grey,
                          fontSize: 12.0),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Container(
                    height: 25.0,
                    width: 80.0,
                    child: Text(
                      '0.0',
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.orangeAccent,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),

                    ),
                  ),
                  SizedBox(width: 55.0),
                  Container(
                    child: FlatButton(
                      color: Colors.redAccent,
                      onPressed: (){},
                      textColor: Colors.white,
                      child: Icon(Icons.remove_red_eye),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}