import 'package:flutter/material.dart';
import 'package:flutter_gin_todo_app/models/todo.dart';

class TodoSort extends StatelessWidget {
  final List<Todo> todos;
  final Function(List<Todo>) onSort;

  TodoSort({required this.todos, required this.onSort});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _sortTodosByTitle();
          },
          child: Text('Sort by Title'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _sortTodosByDate();
          },
          child: Text('Sort by Date'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            _sortTodosByStatus();
          },
          child: Text('Sort by Status'),
        ),
      ],
    );
  }

  void _sortTodosByTitle() {
    List<Todo> sortedList = [...todos];
    sortedList.sort((a, b) => a.title.compareTo(b.title));
    onSort(sortedList);
  }

  void _sortTodosByDate() {
    List<Todo> sortedList = [...todos];
    sortedList.sort((a, b) {
      if (a.date == null && b.date == null) {
        return 0;
      } else if (a.date == null) {
        return 1;
      } else if (b.date == null) {
        return -1;
      } else {
        return a.date!.compareTo(b.date!);
      }
    });
    onSort(sortedList);
  }

  void _sortTodosByStatus() {
    List<Todo> sortedList = [...todos];
    sortedList.sort((a, b) => a.status.compareTo(b.status));
    onSort(sortedList);
  }
}
