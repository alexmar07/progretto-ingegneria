import 'dart:io';

import 'package:INGSW_MezMar/models/movie_list_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:INGSW_MezMar/write_review.dart';
import 'dart:convert';

import 'movie_app_theme.dart';
Color textColor = Colors.black54;
Color textSecondry = Colors.grey;

class SingleMovie extends StatefulWidget {
  SingleMovie(this.id);
  var rooms;
  var id;
  var aminities;
  @override
  _SingleMovieState createState() => _SingleMovieState(id);
}

class _SingleMovieState extends State<SingleMovie> {

  _SingleMovieState(this.id);
  var token;
  var movie;
  var id;

  MovieListData movieData;
  @override
  void initState() {
    var x = MovieListData().fetchSingleMovie(this.id);
    movieData = MovieListData.singleMovie;
    print(movieData.imagePath);
    super.initState();
  }


  Widget buildicons(index) {
    List<Widget> widgets = List<Widget>();
    for (int i=0;i<int.tryParse(index);i++){
      widgets.add (Icon(Icons.star,color: Colors.orange[100],size: 15,));
    }
    return Row(children: widgets);
  }
  bool ames;

//  Widget buildcheck(aminities) {
//    List<Widget> widgets = List<Widget>();
//    aminities = aminities.split(",");
//    //print(aminities);
//    print(aminities + ' lev 3 BUILD');
//
//    for (int i=0; i < aminities.length ;i++){
//      widgets.add (
//        Row(
//          children: <Widget>[
//            Text(aminities[i]),
//
//          ],
//        )
//      );
//    }
//    return Column(children: widgets);
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
        child: FlatButton(
          color: Colors.teal,
          onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WriteReview()),
              );
            },
          textColor: Colors.white,
          child: Text('SCRIVI UNA RECENSIONE',style: TextStyle(

              fontFamily: 'Quicksand',
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                    imageUrl: movieData.imagePath
                ),
                IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                  Navigator.of(context).pop();
                }),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            child: Card(
              child: Container(
                child: Column(
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.fromLTRB(10,10,0,0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(movieData.titleTxt, style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: textColor
                        ),),
                      ),
                    ),


                    Container(
                      padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    'Numero Recensioni: ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: textColor,
                                        fontFamily: 'Quicksand'
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Text(
                                  movieData.reviews.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                      fontFamily: 'Quicksand'
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: Text(
                                    'Valutazione',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: textColor,
                                        fontFamily: 'Quicksand'
                                    ),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                Text(movieData.rating.toString()),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: IconButton(icon: Icon(Icons.favorite,color: Colors.redAccent,), onPressed: (){}),
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Align(
                                  child: IconButton(icon: Icon(Icons.remove_red_eye,color: Colors.teal,), onPressed: (){}),
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTabController(
                        length: 4,
                        initialIndex: 0,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              indicatorColor: Theme.of(context).primaryColor,
                              labelColor: textColor,
                              unselectedLabelColor: textColor,
                              isScrollable: true,
                              tabs: [
                                Tab(text: 'Dettagli',),
                                Tab(text: 'Prezzi',),
                                Tab(text: 'Recensioni',),
                                Tab(text: 'Mappa',)
                              ],
                            ),

                            Container(
                                height: 300.0,
                                child: TabBarView(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(movieData.city),
                                    ),

                                    Center(child: Text('Prezzi here')),
                                    Center(child: Text('Reviews here')),
                                    Center(child: Text('Near by here')),
                                  ],
                                ))
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),

        ],
      ),


    );
  }
  /**
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MovieListData>('movie', movie));
  }
   */
}



class BuildCheck extends StatefulWidget {
  BuildCheck(this.rooms,this.aminities);
  var rooms;
  var aminities;
  @override
  _BuildCheckState createState() => _BuildCheckState(rooms,aminities);
}

class _BuildCheckState extends State<BuildCheck> {
  _BuildCheckState(this.rooms,this.aminities);
  var aminities;
  var rooms;
  bool isChecked;
  List<int> roomsno ;
  List<Map> data = List<Map>(250);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<bookingdata> bdata ;

  void _showDialog(aminities) {
    // flutter defined function
    aminities = aminities.split(",");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Choose Your Aminities'),
          content:  Container(
            height: 150,
            child: ListView.builder(
                itemCount: aminities.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 50,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(aminities[index]),
                            Check(false),
                          ],
                        ),
                      ],
                    ),
                  );
                }
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.orange[100],
              onPressed: (){
                _showDialog(aminities);
              },
              textColor: Colors.white,
              child: Text('Scrivi una recensione',style: TextStyle(
                  fontFamily: 'Quicksand',
                  color: textColor,
                  fontWeight: FontWeight.bold
              ),),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            )
          ],
        );
      },
    );
  }



  Widget buildroom(rooms,aminities) {
    List<Widget> widgets = List<Widget>();
    rooms = rooms.split(",");
    print(aminities + ' lev 1');

    for (int i=0;i<rooms.length;i++){
      bdata[1] = new bookingdata(1,1);
      print(bdata[i].rooms);
      var datasingle = data[i];
      setState(() {
        datasingle["adults"] =0;
        datasingle["rooms"]= 0;
      });

      widgets.add (
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 0.5,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              rooms[i],
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: textColor,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              aminities,
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: textSecondry,
                                  fontSize: 13.0
                              ),
                            ),
                          ],
                        ),
                        FlatButton(
                          color: Colors.orange[100],
                          onPressed: (){
                            _showDialog(aminities);
                          },
                          textColor: Colors.white,
                          child: Text('Scrivi una recensione',style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: textColor,
                              fontWeight: FontWeight.bold
                          ),),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange[100]),
                              borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                     print(datasingle["adults"]);
                                    setState(() {
                                      datasingle["adults"]--;
                                    });
                                    // print(roomsno);

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Text('-', style:TextStyle(fontSize: 15,color: textColor)),
                                  ),
                                ),
                                SizedBox(width: 10,),

                                Text('ROOMS : '+ datasingle["adults"].toString(), style: TextStyle(color: textColor,fontFamily: 'Quicksand',fontSize: 12),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    print(datasingle["adults"]);
                                    setState(() {
                                      data[i];
                                    });
                                    //print(roomsno);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Text('+', style: TextStyle(fontSize: 15,color: textColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange[100]),
                                borderRadius: BorderRadius.all(Radius.circular(12))
                            ),
                            child: Row(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: (){
                                     print(datasingle["adults"]);
                                    setState(() {
                                      datasingle["adults"]--;
                                    });
                                    // print(roomsno);

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Text('-', style:TextStyle(fontSize: 15,color: textColor)),
                                  ),
                                ),
                                SizedBox(width: 10,),

                                Text('ADULTS : '+ data[i]["adults"].toString(), style: TextStyle(color: textColor,fontFamily: 'Quicksand',fontSize: 12),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                   // print(data[i].adults);
                                    setState(() {
                                      datasingle["adults"]++;
                                    });
                                    print(datasingle["adults"]);

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                    child: Text('+', style:TextStyle(fontSize: 15,color: textColor)),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      );
    }
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return buildroom(rooms,aminities);
  }
}


class Check extends StatefulWidget {
  Check(this.check);
  bool check;
  @override
  _CheckState createState() => _CheckState(check);
}

class _CheckState extends State<Check> {
  _CheckState(this.check);
  bool check;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: check,
      onChanged: (bool val){
        setState(() {
          check = val;
        });
      },
    );
  }
}


class bookingdata{
  int rooms = 0;
  int adults = 0;
  bookingdata(this.rooms,this.adults);
}