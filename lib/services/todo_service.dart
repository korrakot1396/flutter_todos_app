import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_gin_todo_app/models/todo.dart';

class TodoService {
  final String apiUrl = 'http://192.168.1.107:8081';

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$apiUrl/tasks'));
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Todo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  Future<void> addTodo(String title) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String body = jsonEncode({'title': title});
    final int contentLength = utf8.encode(body).length;

    final response = await http.post(
      Uri.parse('$apiUrl/tasks'),
      headers: {
        ...headers,
        'Content-Length': '$contentLength',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }


  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/tasks/$id'));
    print('Delete Todo Response: ${response.statusCode} - ${response.body}');
    if (response.statusCode == 200) { // Change condition to handle 200 OK
      print('Todo deleted successfully');
    } else {
      print('Failed to delete todo');
    }
  }

  Future<void> updateTodo(String id, String title, String encodedImage) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Create a map containing the title and encodedImage
    final Map<String, String> requestBody = {
      'title': title,
      'image': encodedImage, // Rename 'encodedImage' to 'image' in the request body
    };

    final String body = jsonEncode(requestBody);
    final int contentLength = utf8.encode(body).length;

    print('Encoded Image: $encodedImage'); // Print the encoded image

    final response = await http.put(
      Uri.parse('$apiUrl/tasks/$id'),
      headers: {
        ...headers,
        'Content-Length': '$contentLength',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo title');
    }
  }


  Future<void> markTodoAsDone(String id) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final String body = jsonEncode({'status': 'COMPLETED'});
    final int contentLength = utf8.encode(body).length;

    final response = await http.put(
      Uri.parse('$apiUrl/tasks/done/$id'),
      headers: {
        ...headers,
        'Content-Length': '$contentLength',
      },
      body: body,
    );

    if (response.statusCode == 200) { // Change condition to handle 200 OK
      print('Todo mark todo as done successfully');
    }
    else {
      print('Error mark todo done');
    }
  }
}


