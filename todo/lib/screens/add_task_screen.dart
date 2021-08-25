import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? newTask;

    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Add Task',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                onChanged: (newValue) {
                  newTask = newValue;
                },
                decoration: InputDecoration(
                    hintText: 'enter your task',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fillColor: Colors.lightBlueAccent),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.lightBlueAccent,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    elevation: 5.0,
                  ),
                  onPressed: () {
                    Provider.of<TaskData>(context, listen: false)
                        .addTask(newTask);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(fontSize: 20.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
