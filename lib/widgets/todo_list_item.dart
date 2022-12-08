import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:untitled/models/todo.dart';
class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todoItem, required this.onDelete}) : super(key: key);

  final Todo todoItem;
  final Function(Todo) onDelete;


  @override
  Widget build(BuildContext context) {
    return Slidable(

      startActionPane: ActionPane(
        extentRatio: 0.25,
        // Painel de ações dentro do Slider
        motion: const BehindMotion(),
        children: [
          SlidableAction( // Se refere a cada botão de ação dentro do ActionPane
            onPressed: (context){onDelete(todoItem);},
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(8), right: Radius.circular(8)),
          ),
          /*SlidableAction( // Se refere a cada botão de ação dentro do ActionPane
            onPressed: null,
            icon: Icons.share,
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
          ),*/
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[400],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, //stretch ocupa a maior largura
              children: [
                Text(
                  DateFormat('dd/MM/yyyy -- EE -- HH:mm').format(todoItem.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  todoItem.title,
                  style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
