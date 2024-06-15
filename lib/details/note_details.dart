import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rex/components/data/notes/notes_data.dart';
import 'package:rex/components/data/notes/notesController.dart';
import 'package:rex/components/tabs/notes.dart';
import 'package:rex/pages/1_home_page.dart'; // Adjust import path as per your file structure

class ViewNotes extends StatefulWidget {
  final NotesData notesDat;
  final int index;

  const ViewNotes({super.key, required this.notesDat, required this.index});

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final noteController = Get.find<NotesController>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.notesDat.title;
    _notesController.text = widget.notesDat.subtitle;
  }

  bool onFocus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Note",
                style: TextStyle(color: Colors.white),
              ),
              onFocus
                  ? IconButton(
                      onPressed: () {
                        final updatedNote = NotesData(
                          title: _titleController.text,
                          dateTime: DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(DateTime.now()),
                          subtitle: _notesController.text,
                        );

                        noteController.notes[widget.index] = updatedNote;
                        noteController.notesBox
                            .putAt(widget.index, updatedNote);

                        Get.off(() => const Notes());
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ))
                  : IconButton(
                      color: Colors.white,
                      onPressed: () {
                        noteController.deleteNoteAt(widget.index);
                        Get.off(() => const Notes());
                      },
                      icon: const Icon(Icons.delete_forever_rounded),
                    )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text(
                  DateFormat('yyyy-MM-dd     HH:mm:ss')
                      .format(DateTime.parse(widget.notesDat.dateTime)),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            TextField(
              controller: _titleController,
              onChanged: (text) {
                setState(() {
                  onFocus = text.isNotEmpty;
                });
              },
              decoration: InputDecoration(
                hintText: "Title",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    onFocus = text.isNotEmpty;
                  });
                },
                controller: _notesController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Enter your notes",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
