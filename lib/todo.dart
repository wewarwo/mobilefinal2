import 'package:flutter/material.dart';
import 'dart:async';
import './todo_model.dart';

todoProvider f = todoProvider();
List<Todo> todos;

class TodoWid extends StatelessWidget {
  final int id;
  final String name;
  TodoWid({Key key, @required this.id, this.name}) : super(key: key);
  Future<void> getit(int userid) async {
    todos = await f.loadDatas(
        "https://jsonplaceholder.typicode.com/todos?userId=${userid}");
    return todos;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text("Todos"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: getit(this.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return createListView(context, snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Todo> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  (values[index].id).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                Text(
                  values[index].title,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  values[index].completed,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
