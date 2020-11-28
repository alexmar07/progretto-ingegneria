import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movie_app_theme.dart';


class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MovieAppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    provinceFilter(),
                    const Divider(
                      height: 1,
                    ),
                    cityFilter(),
                    const Divider(
                      height: 1,
                    ),

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
                  color: MovieAppTheme.buildLightTheme().primaryColor,
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
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Applica',
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
    );
  }







  Widget accomodationFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Tipo di struttura',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),

        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }











  Widget provinceFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Provincia',
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
                  color: Colors.teal,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  onChanged: (String str){
                    setState(() {
                    });
                  },
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.teal
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.teal,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: '',
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

  Widget cityFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Città',
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
                  color: Colors.teal,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  onChanged: (String str){
                    setState(() {
                    });
                  },
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.teal
                  ),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.teal,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: '',
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


  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: MovieAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Filters',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}
