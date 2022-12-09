import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository{

  TodoRepository()  {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  /*void exemple() {
    sharedPreferences.setString('nome','Daniel');
    sharedPreferences.getString('nome');
  }*/

  void saveTodoList(List<Todo> todos){
    final String jsonString  = jsonEncode(todos);
    sharedPreferences.setString(todoListKey,jsonString);
  }

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final List jsonDecode = json.decode(jsonString) as List;
    return jsonDecode.map((e) => Todo.fromJson(e)).toList();
  }
}