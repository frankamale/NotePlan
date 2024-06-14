import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'notes_data.dart';

class NotesController extends GetxController {
  late Box<NotesData> notesBox;
  var notes = <NotesData>[].obs;

  @override
  void onInit() {
    super.onInit();
    notesBox = Hive.box<NotesData>('notesBox');
    loadNotes();
  }

  void loadNotes() {
    notes.value = notesBox.values.toList();
  }

  void addNotes(NotesData note) {
    notesBox.add(note);
    notes.add(note);
  }

  void deleteNoteAt(int index) {
    notesBox.deleteAt(index);
    notes.removeAt(index);
  }
}
