import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rex/components/data/schedule/schedule_data.dart';
import 'package:rex/pages/1_home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'components/data/notes/notesController.dart';
import 'components/data/notes/notes_data.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NotesDataAdapter());
  Hive.registerAdapter(ScheduleDataAdapter());

  await Hive.openBox<NotesData>('notesBox');
  await Hive.openBox<ScheduleData>('scheduleBox');

  Get.put(NotesController());

  // Initialize timezone package
  tz.initializeTimeZones();

  // Initialize notifications plugin
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

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
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
