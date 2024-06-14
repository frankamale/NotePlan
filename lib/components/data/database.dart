import 'package:get/get.dart';
import 'package:rex/components/data/notes_data.dart';
import 'package:rex/components/data/schedule_data.dart';

class DataBaseController extends GetxController {
  var schedules = <ScheduleData>[].obs;

  void addSchedule(ScheduleData schedule) {
    schedules.add(schedule);
  }

  void delete(int index) {
    schedules.removeAt(index);
  }
}
