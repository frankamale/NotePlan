import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rex/components/data/schedule_data.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create an activity',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Enter Activity: ",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: _activityController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Activity"),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                maxLines: 4,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "(optional)",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Enter date",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                onTap: () {
                  _selectDate();
                },
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Date",
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.calendar_today)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Time of activity",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                onTap: () {
                  _selectTime();
                },
                controller: _timeController,
                readOnly: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Time",
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: const Icon(Icons.access_time)),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    )),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    )),
                    onPressed: () {
                      addTask();
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
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
        subheading: "${_dateController.text}      ${_timeController.text} ",
        description: _descriptionController.text.isEmpty
            ? "No description Found"
            : _descriptionController.text,
      );

      var box = Hive.box<ScheduleData>("myBox");
      await box.add(newSchedule);

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
}
