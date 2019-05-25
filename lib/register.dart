import './login.dart';
import './user.dart';
import 'package:flutter/material.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _id;
  String _user;
  String _pass;
  String _name;
  String _age;
  List<User> accs = [];
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
            title: Text("Register"),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: 'User Id',
                      prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value.length < 6 || value.length > 12) {
                          return ("UserID need 6-12 chars");
                        } else {
                          _user = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Name',
                      prefixIcon: Icon(Icons.person_pin)
                      ),
                      validator: (value) {
                        if (" ".allMatches(value).length!=1) {
                          return ("Name need 1 space");
                        } else {
                          _name = value;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Age',
                      prefixIcon: Icon(Icons.calendar_today)),
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
                      decoration: InputDecoration(hintText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value.length < 6) {
                          return ("Password require at least 6 chars");
                        } else {
                          _pass = value;
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('REGISTER NEW ACCOUNT'),
                      onPressed: () async {
                        await acc.open("account.db");
                        if (_formKey.currentState.validate()) {
                          User user1 = User();
                          user1.user = _user;
                          user1.pass = _pass;
                          user1.name = _name;
                          user1.age = _age;
                          await acc.insert(user1);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              )),
        ));
  }
}
