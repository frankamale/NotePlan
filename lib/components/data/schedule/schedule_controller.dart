import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rex/components/data/schedule/schedule_data.dart';

class ScheduleController extends GetxController {
  late Box<ScheduleData> scheduleBox;
  var schedules = <ScheduleData>[].obs;

  @override
  void onInit() {
    super.onInit();
    scheduleBox = Hive.box<ScheduleData>('scheduleBox');
    loadSchedule();
  }

  void loadSchedule() {
    schedules.value = scheduleBox.values.toList();
  }

  void addSchedule(ScheduleData sched) {
    schedules.add(sched);
    scheduleBox.add(sched);
    loadSchedule(); // Refresh the schedule
  }

  void delete(int index) {
    scheduleBox.deleteAt(index);
    schedules.removeAt(index);
  }
}
