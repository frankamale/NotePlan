import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rex/components/data/schedule/schedule_controller.dart';
import 'package:rex/components/data/schedule/schedule_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'package:timezone/timezone.dart' as tz;

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _activityController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final schedule = ScheduleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Reminder",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          height: 700,
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Activity Title:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _activityController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      enabledBorder: OutlineInputBorder(),
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      enabledBorder: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Date:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _dateController,
                    onTap: () {
                      _selectDate();
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Date",
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(Icons.calendar_today)),
                  ),
                  const Text(
                    "Time:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _timeController,
                    onTap: () {
                      _selectTime();
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Time",
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: const Icon(Icons.timelapse)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          )),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {
                            addTask();
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        context: context);
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> addTask() async {
    if (_activityController.text.isNotEmpty) {
      var newSchedule = ScheduleData(
        title: _activityController.text,
        date: '"{$_dateController.text} ${_timeController.text}"',
        description: _descriptionController.text.isEmpty
            ? "No description Found"
            : _descriptionController.text,
      );

      var box = Hive.box<ScheduleData>("scheduleBox");
      await box.add(newSchedule);

      scheduleAlarm(newSchedule);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Activity Created'),
        duration: Duration(seconds: 2),
      ));
      Get.back();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.black,
          content: Text('Activity field is empty'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  void scheduleAlarm(ScheduleData schedule) {
    final scheduledDate = DateFormat('yyyy-MM-dd HH:mm').parse(schedule.date);

    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder: ${schedule.title}',
      schedule.description,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Notification',
          'Pending task',
          channelDescription: "",
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
