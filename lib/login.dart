import './file.dart';
import './register.dart';
import './main.dart';
import './user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

AccProvider acc = AccProvider();
SharedPreferences prefs;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _id;
  String _pass;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Image.network(
                      'http://locksmithelpasotexas.com/wp-content/uploads/2018/02/Laser-Cut-Car-Keys-Locksmith-in-El-Paso-TX.jpg',
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'User Id',
                      prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ("Please fill username");
                        } else {
                          _id = value;
                        }
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password',
                      prefixIcon: Icon(Icons.lock)),
                      validator: (value) {
                        if (value.isEmpty) {
                          return ("Please fill password");
                        } else {
                          _pass = value;
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await acc.open("account.db");
                          final prefs = await SharedPreferences.getInstance();
                          if (_formKey.currentState.validate()) {
                            final user1 = await acc.getUser(_id);
                            if (user1 == null) {
                              Toast.show("Invalid user or password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            } else {
                              // _scaffoldKey.currentState.showSnackBar(
                              //     SnackBar(content: Text(user1.pass)));
                              if (user1.pass == _pass) {
                                // _scaffoldKey.currentState.showSnackBar(
                                //     SnackBar(content: Text("Done!!!")));

                                prefs.setInt('id', user1.id);
                                prefs.setString('name', user1.name);
                                // _scaffoldKey.currentState.showSnackBar(SnackBar(
                                //     content:
                                //         Text(prefs.getInt('id').toString())));
                                // _scaffoldKey.currentState.showSnackBar(SnackBar(
                                //     content: Text(prefs.getString('name'))));
                                if (prefs.getInt('id') != null) {
                                  Navigator.pushNamed(context, "/home");
                                }
                                
                              } else {
                                Toast.show("Invalid user or password", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                              }
                            }
                          }
                        } else {
                          Toast.show("Please fill out this form", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        }
                      },
                    ),
                    FlatButton(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text("Register New Account"),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                    ),
                    // FlatButton(
                    //   child: Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: Text("Clean DB"),
                    //   ),
                    //   onPressed: () async {
                    //     final users = await acc.getAllUser();
                    //     for (var user in users) {
                    //       acc.deleteAll();
                    //     }
                    //   },
                    // ),
                  ],
                ),
              )),
        ));
  }
  // ···
}
