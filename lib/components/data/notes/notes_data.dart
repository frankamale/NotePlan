import 'package:hive/hive.dart';

part 'notes_data.g.dart'; // Make sure this part directive is added

@HiveType(typeId: 1)
class NotesData extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String subtitle;

  @HiveField(2)
  late String dateTime;

  NotesData(
      {required this.title, required this.subtitle, required this.dateTime});
}
