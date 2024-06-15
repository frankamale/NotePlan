import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rex/components/data/notes/notes_data.dart';
import 'package:rex/components/data/schedule/schedule_data.dart';
import 'package:rex/components/data/notes/notesController.dart';
import 'package:hive/hive.dart';
import 'package:rex/pages/1_home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NotesDataAdapter());
  Hive.registerAdapter(ScheduleDataAdapter());

  await Hive.openBox<NotesData>('notesBox');
  await Hive.openBox<ScheduleData>('scheduleBox');

  Get.put(NotesController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        // useMaterial3: true, // There is no useMaterial3 in ThemeData
      ),
      home: const HomePage(),
    );
  }
}
