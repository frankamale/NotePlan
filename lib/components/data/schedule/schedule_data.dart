import 'package:hive/hive.dart';

part 'schedule_data.g.dart';

@HiveType(typeId: 2)
class ScheduleData extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String date;

  @HiveField(2)
  late String description;

  ScheduleData({
    required this.title,
    required this.date,
    required this.description,
  });
}
