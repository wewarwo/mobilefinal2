import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  final int userid;
  final int id;
  final String title;
  final String completed;

  Todo({this.userid, this.id, this.title, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
      return Todo(
      userid: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: (json['completed'] ? "complete" : ""),
    );
  }
}

class todoList {
  final List<Todo> todos;
  todoList({
    this.todos,
  });
  factory todoList.fromJson(List<dynamic> parsedJson) {
    List<Todo> todos = new List<Todo>();
    todos = parsedJson.map((i) => Todo.fromJson(i)).toList();
    
    return new todoList(
      todos: todos,
    );
  }
}

class todoProvider {
  Future<List<Todo>> loadDatas(String url) async {
    http.Response resp = await http.get(url);
    final jresp = json.decode(resp.body);
    todoList friendList = todoList.fromJson(jresp);
    return friendList.todos;
  }
}