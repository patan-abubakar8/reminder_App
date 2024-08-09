import 'package:flutter/material.dart';

class ReminderListPage extends StatelessWidget {
  final List<Map<String, String>> reminders;
  final void Function(Map<String, String>) onDelete;

  ReminderListPage({required this.reminders, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return ListTile(
            title: Text(
                '${reminder['activity']} on ${reminder['day']} at ${reminder['time']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                onDelete(reminder);
              },
            ),
          );
        },
      ),
    );
  }
}
