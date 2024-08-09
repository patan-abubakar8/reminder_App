import 'package:flutter/material.dart';
import 'reminder_list_page.dart';

void main() {
  runApp(ReminderApp());
}

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReminderHomePage(),
    );
  }
}

class ReminderHomePage extends StatefulWidget {
  @override
  _ReminderHomePageState createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  String? selectedDay;
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedActivity;

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  // Create a list to store the reminders
  List<Map<String, String>> reminders = [];

  void _deleteReminder(Map<String, String> reminder) {
    setState(() {
      reminders.remove(reminder);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Day'),
              value: selectedDay,
              items: daysOfWeek.map((day) {
                return DropdownMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDay = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Select Time'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  setState(() {
                    selectedTime = picked;
                  });
                }
              },
              child: Text('Choose Time: ${selectedTime.format(context)}'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Activity'),
              value: selectedActivity,
              items: activities.map((activity) {
                return DropdownMenuItem(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedActivity = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDay != null && selectedActivity != null) {
                    final newReminder = {
                      'day': selectedDay!,
                      'time': selectedTime.format(context),
                      'activity': selectedActivity!,
                    };

                    setState(() {
                      reminders.add(newReminder);
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReminderListPage(
                          reminders: reminders,
                          onDelete: _deleteReminder,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Set Reminder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
