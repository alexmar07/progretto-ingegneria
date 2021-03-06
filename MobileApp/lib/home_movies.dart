import 'package:flutter/material.dart';
import 'movie_list_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _width;
  double _height;
  @override
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: GestureDetector(
                child: Icon(Icons.menu),
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 12,
                )
              ],
              expandedHeight: _height / 5.5,
              floating: false,
              pinned: true,
              backgroundColor: Colors.teal,
              //#f02730
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                titlePadding: EdgeInsets.only(top: 30.0),
                title: Center(
                  child: Text(
                    "CineMates20 by MezMar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins-regular',
                        fontSize: 16),
                  ),
                ),
              ),
              bottom: PreferredSize(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    width: _width,
                    //height: _height/15,
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      onTap: () {
                        //   FocusScope.of(context).requestFocus(FocusNode());
                        //   Navigator.push<dynamic>(
                        //     context,
                        //     MaterialPageRoute<dynamic>(
                        //         builder: (BuildContext context) =>
                        //             MovieListScreen(),
                        //         fullscreenDialog: true),
                        //   );
                      },
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 0.0, bottom: 0),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                          hintText: "Cerca un film",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0,
                              fontFamily: 'poppins-regular'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  preferredSize: Size(_width, _height / 45)),
            ),
          ];
        },
        body: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage('assets/images/cinema_home.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MovieListScreen()));
  }
}
