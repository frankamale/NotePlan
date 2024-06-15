import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rex/components/data/schedule/schedule_controller.dart';
import 'package:rex/components/data/schedule/schedule_data.dart';
import 'package:rex/components/forms/add_schedule.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final scheduleController = Get.put(ScheduleController());

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.openBox<ScheduleData>('scheduleBox');
    scheduleController.loadSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Schedule",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
            itemCount: scheduleController.schedules.length,
            itemBuilder: (context, index) {
              final schedule = scheduleController.schedules[index];
              return Dismissible(
                key: Key(schedule.key.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  _deleteSchedule(index);
                },
                child: Card(
                  child: ListTile(
                    title: Text(schedule.title),
                    subtitle: Text(schedule.description),
                    trailing: Text(schedule.date),
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => const AddSchedule());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _deleteSchedule(int index) {
    scheduleController.delete(index);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: Text('Activity Deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
