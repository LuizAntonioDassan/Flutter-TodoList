import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/models/todo.dart';
import 'package:untitled/reporsitory/todo_repository.dart';

import '../widgets/todo_list_item.dart';


class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController emailControle = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> list = [];
  
  @override
  void initState(){
    super.initState();
    
    todoRepository.getTodoList().then((value){
      setState(() {
        list = value;
      });
    });
  }

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
                      onPressed: () {
                        String text = emailControle.text;
                        setState(() {
                          if (emailControle.text.isNotEmpty) {
                            Todo newTodo = Todo(
                                title: text,
                                dateTime: DateTime.now()
                            );
                            list.add(newTodo);
                          }
                          emailControle.clear();
                          todoRepository.saveTodoList(list);
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
                           */ /* subtitle: Text("Até Final de Dezembro ter terminado o Curso."),
                            leading: Icon(Icons.save, size: 30,),*/ /*
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
                        child: Text(
                            "Voce possui ${list.length} tarefas pendentes")
                    ),
                    ElevatedButton(
                      onPressed: cleanListDialog,
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


  void cleanListDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Limpar tudo?"),
          content: Text("Tem certeza que deseja apagar todas as tarefas?"),
          actions: [
            TextButton(
                onPressed: cleanList,
                style: TextButton.styleFrom(primary: Colors.red),
                child: Text("Limpar")),
            TextButton(
                onPressed: () {Navigator.of(context, rootNavigator: true).pop();},
                child: Text("Cancelar")),

          ],
        )
    );

  }

  void cleanList(){
    setState(() {
      list.clear();
    });
    Navigator.of(context, rootNavigator: true).pop();
  }

  void login() {
    String text = emailControle.text;
    print(text);
    emailControle.clear();
  }

  void onDelete(Todo todo) {
    setState(() {
      list.remove(todo);
    });
  }


}
