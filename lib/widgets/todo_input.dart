import 'package:flutter/material.dart';

class TodoInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmit;

  TodoInput({required this.controller, required this.onSubmit});

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a todo';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter todo',
                errorStyle: TextStyle(color: Colors.red), // Style for error text
              ),
              validator: _validateInput,
              onFieldSubmitted: onSubmit,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (_validateInput(controller.text) == null) {
                onSubmit(controller.text);
                controller.clear();
              } else {
                // Show snackbar or any other feedback to inform user about the error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please enter a todo'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
