import 'package:hive/hive.dart';

part 'schedule_data.g.dart'; // This file will be generated

@HiveType(typeId: 0)
class ScheduleData {
  @HiveField(0)
  String title;

  @HiveField(1)
  String subheading;

  @HiveField(2)
  String description;

  ScheduleData({
    required this.title,
    required this.subheading,
    this.description = "No description Found",
  });
}
