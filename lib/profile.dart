import './file.dart';
import './login.dart';
import './user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _id;
  String _user;
  String _pass;
  String _name;
  String _age;
  String _quote;
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: 'User Id'),
                      validator: (value) {
                        if (value.length < 6 || value.length > 12) {
                          return ("UserID need 6-12 chars");
                        } else {
                          _user = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Name'),
                      validator: (value) {
                        if (" ".allMatches(value).length!=1) {
                          return ("Name need 1 space");
                        } else {
                          _name = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Age'),
                      validator: (value) {
                        if (value.isEmpty || int.parse(value) < 10 || int.parse(value) > 80) {
                          return ("Age must between 10-80");
                        } else {
                          _age = value;
                        }
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value.length < 6) {
                          return ("Password require at least 6 chars");
                        } else {
                          _pass = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Quote'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ("Please fill the box");
                        } else {
                          _quote = value;
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        await acc.open("account.db");
                        final prefs = await SharedPreferences.getInstance();
                        if (_formKey.currentState.validate()) {
                          User user1 = User();
                          user1.id = prefs.getInt('id');
                          user1.user = _user;
                          user1.pass = _pass;
                          user1.name = _name;
                          user1.age = _age;
                          await acc.update(user1);

                          await textFile().writeText(_quote);
                          prefs.setString('name', _name);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
  // ···
}
