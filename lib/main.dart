import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rex/pages/1_home_page.dart';

import 'components/data/notesController.dart';
import 'components/data/notes_data.dart';
import 'components/data/schedule_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleDataAdapter());
  Hive.registerAdapter(NotesDataAdapter());

  await Hive.openBox<ScheduleData>("myBox");
  await Hive.openBox<NotesData>('notesBox');

  Get.put(NotesController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
