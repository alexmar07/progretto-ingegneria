import 'package:INGSW_MezMar/data/api_movie.dart';
import 'package:INGSW_MezMar/data/api_users.dart';
import 'package:INGSW_MezMar/models/users.dart';
import 'package:INGSW_MezMar/models/users_list.dart';
import 'package:INGSW_MezMar/models/movie.dart';
import 'package:flutter/material.dart';
import 'movie.dart';

class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UsersRepository().getUsers(1, ''),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return UsersListView(users: snapshot.data);
          }
        },
      ),
    );
  }
}

class UsersListView extends StatefulWidget {
  final UsersList users;

  const UsersListView({
    this.users,
    Key key,
  }) : super(key: key);

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  ScrollController _scrollController = new ScrollController();

  List<Users> users;
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        UsersRepository().getUsers(currentPage + 1, '').then((val) {
          currentPage = val.page;
          setState(() {
            if (users.isNotEmpty) {
              users.addAll(val.users);
            }
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    users = widget.users.users;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: users.isEmpty
          ? Center(child: Text('La ricerca non ha prodotti risultati'))
          : ListView.builder(
              itemCount: users.length,
              controller: _scrollController,
              itemBuilder: (BuildContext ctx, int i) {
                return itemCard(users[i]);
              },
            ),
    );
  }

  Widget itemCard(Users user) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 200.0,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(4)),
              //     image: DecorationImage(
              //         image: NetworkImage(movie.backdropPath),
              //         fit: BoxFit.cover)),
              child: Icon(Icons.face),
            ),
            SizedBox(width: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.firstName + ' ' + user.lastName,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 250.0,
                      child: Text(
                        'Username: ' + user.username,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.grey,
                            fontSize: 12.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 250.0,
                        ),
                        Container(
                          child: FlatButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              String message =
                                  UsersRepository().sendRequestLink(user.id);
                            },
                            textColor: Colors.white,
                            child: Icon(Icons.add),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
