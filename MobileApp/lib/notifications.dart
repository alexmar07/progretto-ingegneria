import 'package:INGSW_MezMar/data/api_users.dart';
import 'package:INGSW_MezMar/models/notifications_list.dart';
import 'package:INGSW_MezMar/models/notify.dart';
import 'package:flutter/cupertino.dart';
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
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Provider.of<Tabs>(context).changeIndex(0);
          },
        ),
        title: Text(
          'Richieste di collegamento',
          style: TextStyle(
              fontFamily: 'poppins-regular', fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder(
        future: UsersRepository().getNotifications(1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            return NotificationsListView(notifications: snapshot.data);
          }
        },
      ),
    );
  }
}

class NotificationsListView extends StatefulWidget {
  final NotificationsList notifications;

  NotificationsListView({this.notifications, Key key}) : super(key: key);

  @override
  _NotificationsListViewState createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  ScrollController _scrollController = new ScrollController();
  List<Notify> notifications;
  String message;
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        UsersRepository().getNotifications(currentPage + 1).then((val) {
          currentPage = val.page;
          setState(() {
            if (notifications.isNotEmpty) {
              notifications.addAll(val.notifications);
              return false;
            }
          });
        });
      }
    }
    return true;
  }

  @override
  void initState() {
    notifications = widget.notifications.notifications;
    message = widget.notifications.message;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
      child: notifications.isEmpty
          ? Center(child: Text('Non ci notifiche'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext ctx, int i) {
                return itemCard(notifications[i], i);
              },
            ),
    );
  }

  Widget itemCard(Notify notification, int index) {
    return Padding(
      child: Container(
        height: 163.0,
        width: double.infinity,
        //color: Colors.white,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5.0),
                    Container(
                      width: 375,
                      child: Text(
                        notification.username,
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
                        notification.firstname + ' ' + notification.lastname,
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
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(
                          color: Colors.teal,
                          onPressed: () async {
                            var response = await UsersRepository()
                                .acceptOrRefuseRequest(
                                    notification.id, 'accept_request');
                            setState(() {
                              notifications.removeAt(index);
                            });
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(response['message']),
                                  );
                                });
                          },
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        FlatButton(
                          color: Colors.redAccent,
                          onPressed: () async {
                            var response = await UsersRepository()
                                .acceptOrRefuseRequest(
                                    notification.id, 'reject_request');
                            setState(() {
                              notifications.removeAt(index);
                            });
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(response['message']),
                                  );
                                });
                          },
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
