import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gin_todo_app/models/todo.dart';
import '../services/todo_service.dart';
import 'package:image_picker/image_picker.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  final TodoService todoService;

  TodoList({required this.todos, required this.todoService});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (context, index) {
        final todo = widget.todos[index];
        return Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Dismissible(
            key: Key(todo.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async {
              try {
                await widget.todoService.deleteTodo(todo.id);
                setState(() {
                  widget.todos.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Todo deleted successfully"),
                  ),
                );
              } catch (e) {
                print("Error deleting todo: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Failed to delete todo: $e"),
                  ),
                );
              }
            },
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Delete Todo"),
                    content: Text("Are you sure you want to delete this todo?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false); // Return false if cancel
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true); // Return true if delete
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              title: Text(todo.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (todo.description!.isNotEmpty) Text(todo.description!),
                  SizedBox(height: 5),
                  Text('Date: ${todo.date ?? 'Unknown'}'),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(todo.status),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      todo.status,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (todo.image != null && todo.image.isNotEmpty)
                    Image.memory(
                      base64Decode(todo.image), // Decode the base64 string
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  Visibility(
                    visible: todo.status != 'COMPLETED',
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          await widget.todoService.markTodoAsDone(todo.id);
                          List<Todo> updatedTodos = await widget.todoService.fetchTodos();
                          setState(() {
                            widget.todos.clear();
                            widget.todos.addAll(updatedTodos);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Todo marked as done successfully"),
                            ),
                          );
                        } catch (e) {
                          print("Error marking todo as done: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Failed to mark todo as done: $e"),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.check),
                      label: Text('Mark as Done'),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _editTitle(context, todo); // Call function to edit title
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Edit Title'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'IN_PROGRESS') {
      return Colors.grey;
    } else if (status == 'COMPLETED') {
      return Colors.green;
    } else {
      return Colors.grey; // Default color if status is neither 'In Progress' nor 'Success'
    }
  }

  void _editTitle(BuildContext context, Todo todo) async {
    String newTitle = await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController(text: todo.title);
        XFile? _pickedImage;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Edit Todo Title"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Enter new title"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      XFile? pickedImage = await _pickImage();
                      if (pickedImage != null) {
                        setState(() {
                          _pickedImage = pickedImage;
                        });
                      }
                    },
                    child: Text('Pick Image'),
                  ),
                  if (_pickedImage != null)
                    Image.file(File(_pickedImage!.path)),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog without saving changes
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    String? encodedImage;
                    if (_pickedImage != null) {
                      List<int> imageBytes = await _pickedImage?.readAsBytes() ?? [];
                      encodedImage = base64Encode(imageBytes);
                    }
                    await _updateTodo(todo.id, _controller.text, encodedImage);
                    Navigator.of(context).pop(_controller.text); // Return the new title
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      try {
        await widget.todoService.updateTodo(todo.id, newTitle, "");
        List<Todo> updatedTodos = await widget.todoService.fetchTodos();
        setState(() {
          widget.todos.clear();
          widget.todos.addAll(updatedTodos);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Todo title updated successfully"),
          ),
        );
      } catch (e) {
        print("Error updating todo title: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update todo title: $e"),
          ),
        );
      }
    }
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  }

  Future<void> _updateTodo(String todoId, String newTitle, String? encodedImage) async {
    try {
      await widget.todoService.updateTodo(todoId, newTitle, encodedImage!);
    } catch (e) {
      print("Error updating todo: $e");
      throw e;
    }
  }
}
