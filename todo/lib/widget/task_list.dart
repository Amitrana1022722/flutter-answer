import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/widget/task_tile.dart';
import 'package:todo/models/task.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks.elementAt(index);
            return GestureDetector(
              onLongPress: () {
                taskData.deleteTask(index);
              },
              child: TaskTile(
                isChecked: task.isDone,
                title: task.title,
                checkedState: (bool? checkedState) {
                  taskData.updateTask(task);
                },
              ),
            );
          },
          itemCount: taskData.taskCount);
    });
  }
}
