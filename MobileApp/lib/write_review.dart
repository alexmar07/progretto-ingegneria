import 'dart:io';

import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class WriteReview extends StatefulWidget {
  final int movieId;
  WriteReview({this.movieId});
  @override
  _WriteReviewState createState() => _WriteReviewState(movieId: movieId);
}

// ignore: camel_case_types

class _WriteReviewState extends State<WriteReview> {
  String startValutation = '1';
  String description = '';
  String title = '';
  int movieId;

  _WriteReviewState({this.movieId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scrivi una recensione',
          style: TextStyle(
              fontFamily: 'poppins-regular', fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Divider(
                        height: 30,
                      ),
                      reviewTitleField(),
                      const Divider(
                        height: 10,
                      ),
                      reviewDescriptionField(),
                      const Divider(
                        height: 10,
                      ),
                      reviewValutationBox(),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 8),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        // Navigator.pop(context);
                        var response = await MovieRepository().addReview(
                            movieId,
                            title,
                            description,
                            int.parse(startValutation));

                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(response['message']),
                              );
                            }).then((val) {
                          if (response['success']) {
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: Center(
                        child: Text(
                          'INVIA RECENSIONE',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget reviewTitleField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Titolo',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15.0, right: 40.0, top: 5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.teal, width: 0.5, style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  onChanged: (String str) {
                    setState(() {
                      title = str;
                    });
                  },
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.teal),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.teal,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Inserisci il titolo',
                    hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget reviewDescriptionField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Descrizione',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15.0, right: 40.0, top: 5.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.teal, width: 0.5, style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  onChanged: (String str) {
                    setState(() {
                      description = str;
                    });
                  },
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.teal),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.teal,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Inserisci la recensione',
                    hintStyle: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget reviewValutationBox() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Valutazione',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
          DropdownButton<String>(
            value: startValutation,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 20,
            style: TextStyle(color: Colors.teal),
            underline: Container(
              height: 2,
              color: Colors.teal,
            ),
            onChanged: (String newValue) {
              setState(() {
                startValutation = newValue;
              });
            },
            items: <String>['1', '2', '3', '4', '5']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ]);
  }
}
