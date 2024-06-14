import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rex/components/data/database.dart';
import 'package:rex/components/forms/add_schedule.dart';
import 'package:rex/details/schedule_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final dbController = Get.put(DataBaseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SCHEDULE',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: dbController.schedules.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => ScheduleDetails(index: index, data: dbController));
              },
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  dbController.delete(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.black,
                      content: Text('Activity deleted'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
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
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text(dbController.schedules[index].title),
                        subtitle:
                            Text(dbController.schedules[index].subheading),
                        leading: const Icon(Icons.calendar_month_outlined),
                        trailing: const Icon(Icons.access_time),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddSchedule());
        },
        backgroundColor: Colors.black,
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
