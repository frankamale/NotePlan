import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../../details/note_details.dart';
import '../data/notes/notesController.dart';
import '../forms/add_note.dart'; // Adjust import path as per your file structure

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final noteController = Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    // Ensure Hive is initialized and the box is opened
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox('notes');
    noteController.loadNotes(); // Assuming you have a method to load notes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (noteController.notes.isEmpty) {
          return const Center(
            child: Text(
              'Add notes here',
              style: TextStyle(color: Colors.grey, fontSize: 30),
            ),
          );
        }

        return ListView.builder(
          itemCount: noteController.notes.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: ListTile(
                title: Text(noteController.notes[index].title),
                subtitle: Text(noteController.notes[index].subtitle,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                leading: const Icon(Icons.note),
                trailing: Text(
                  DateFormat('yyyy-MM-dd     HH:mm:ss')
                      .format(DateTime.parse(DateTime.now().toString())),
                  style: const TextStyle(fontSize: 15),
                ),
                onTap: () {
                  Get.to(() => ViewNotes(
                      notesDat: noteController.notes[index], index: index));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => const AddNotes());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
