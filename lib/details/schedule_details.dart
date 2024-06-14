import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/data/database.dart';
import '../components/data/schedule_data.dart';

class ScheduleDetails extends StatelessWidget {
  final int index; // Index of the schedule to display
  final DataBaseController data; // Controller instance containing schedule data

  const ScheduleDetails({Key? key, required this.index, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the schedule data for the specified index
    ScheduleData schedule = data.schedules[index];

    final parts = data.schedules[index].subheading.split('      ');
    final time = parts.length > 1 ? parts[1] : '';

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Activity",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: Card(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Text(
                        schedule.title.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(children: [
                        const Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          schedule.description.isNotEmpty
                              ? schedule.description
                              : 'No description available',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ]),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Date: ',
                            style: TextStyle(fontSize: 25, color: Colors.black),
                          ),
                          Text(
                            parts[0],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Time: ',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black)),
                          Text(
                            time,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
