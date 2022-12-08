import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/models/todo.dart';

import '../widgets/todo_list_item.dart';


class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController emailControle = TextEditingController();

  List<Todo> list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: emailControle,
                        decoration: InputDecoration(
                          labelText: "Tarefa",
                          hintText: "Digite aqui",
                          //prefixText: "R\$ ",
                          //suffixText: ", 00",
                        ),
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        String text = emailControle.text;
                        setState(() {
                          if(emailControle.text.isNotEmpty) {
                            Todo newTodo = Todo(
                                title: text,
                                dateTime: DateTime.now()
                            );
                            list.add(newTodo);
                          }
                          emailControle.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen,
                          padding: EdgeInsets.all(12)),
                      child: Icon(
                        Icons.save,
                        size: 40,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18),

                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(Todo todo in list)
                        TodoListItem(
                          todoItem: todo,
                          onDelete: onDelete,
                        )


                         /* ListTile(
                            title: Text(elemento),
                           textColor: Colors.black87,
                           tileColor: Colors.blueGrey,
                           *//* subtitle: Text("Até Final de Dezembro ter terminado o Curso."),
                            leading: Icon(Icons.save, size: 30,),*//*
                          ),*/

                     /* Container(
                        color: Colors.red,
                        height: 50,
                      ),
                      Container(
                        color: Colors.green,
                        height: 50,
                      ),
                      Container(
                        color: Colors.yellowAccent,
                        height: 50,
                      )*/

                   /*   ListTile(
                        title: Text("Tarefa 1"),
                        subtitle: Text("Até Final de Dezembro ter terminado o Curso."),
                        leading: Icon(Icons.save, size: 30,),
                      ),*/
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Expanded(
                        child: Text("Voce possui ${list.length} tarefas pendentes")
                    ),
                    ElevatedButton(
                      onPressed: cleanList,
                      child: Text("Limpar"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  void cleanList(){
    setState(() {
      list.clear();
    });
  }

  void login() {
    String text = emailControle.text;
    print(text);
    emailControle.clear();
  }

  void onDelete(Todo todo){
    setState(() {
      list.remove(todo);
    });
  }


}
