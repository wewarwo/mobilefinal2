import './file.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _quote;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _name;

  // @override
  // void initState() {
  //   super.initState();
  //   userProvider.open('member.db').then((r) {
  //     print("open success");
  //     getUsers();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Future<String> getPrefs() async {
      final prefs = await SharedPreferences.getInstance();
      final _quote = await textFile().readText();
      //await _texts.writeText("GO GO GO");
      _name = prefs.getString('name');
      return _quote;
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Home"),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  FutureBuilder<String>(
                    future: getPrefs(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('loading...');
                        default:
                          if (snapshot.hasError) {
                            return new Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              "Hello $_name\n${snapshot.data}",
                              textAlign: TextAlign.center,
                            );
                          }
                      }
                      // if (snapshot.hasError) {
                      //   // return new Text('Error: ${snapshot.error}');
                      //   return new Center(
                      //     child: Text("No data found..."),
                      //   );
                      // } else {
                      //   // return new Text('Result: ${snapshot.data[0].title}');
                      // return Text(
                      //   "Welcome $_name",
                      //   textAlign: TextAlign.center,
                      // );
                      // }
                    },
                  ),
        
                  RaisedButton(
                    child: Text('PROFILE SETUP'),
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                  ),
                  RaisedButton(
                    child: Text('MY FRIENDS'),
                    onPressed: () {
                      Navigator.pushNamed(context, "/friend");
                    },
                  ),
                  RaisedButton(
                    child: Text('SIGN OUT'),
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
        ));
  }

  // ···
}
