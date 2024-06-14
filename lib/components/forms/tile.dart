import 'package:flutter/material.dart';
import 'package:rex/components/data/notes_data.dart';
import 'package:get/get.dart';

import '../../details/note_details.dart';

class NotesTile extends StatelessWidget {
  final NotesData notesDat;
  final int index;

  const NotesTile({Key? key, required this.notesDat, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(notesDat.title),
      subtitle: Text(notesDat.subtitle),
      trailing: Text(notesDat.dateTime),
      onTap: () {
        Get.to(() => ViewNotes(notesDat: notesDat, index: index));
      },
    );
  }
}
