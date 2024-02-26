import 'package:flutter/material.dart';
import 'package:flutter_gin_todo_app/services/todo_service.dart';
import 'package:flutter_gin_todo_app/widgets/todo_input.dart';
import 'package:flutter_gin_todo_app/widgets/todo_list.dart';
import 'package:flutter_gin_todo_app/models/todo.dart';
import 'package:flutter_gin_todo_app/widgets/todo_sort.dart'; // Step 1: Import TodoSort widget file

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _controller;
  late List<Todo> _todos;
  final TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _todos = [];
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: [
          TodoInput(controller: _controller, onSubmit: _addTodo),
          TodoSort(todos: _todos, onSort: _sortTodos), // Step 2: Add TodoSort widget
          Expanded(
            child: TodoList(todos: _todos, todoService: TodoService()),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchTodos() async {
    try {
      final todos = await _todoService.fetchTodos();
      setState(() {
        _todos = todos;
      });
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }

  Future<void> _addTodo(String title) async {
    try {
      await _todoService.addTodo(title);
      _controller.clear();
      _fetchTodos();
    } catch (e) {
      print('Error adding todo: $e');
    }
  }

  void _sortTodos(List<Todo> sortedTodos) {
    setState(() {
      _todos = sortedTodos;
    });
  }
}
