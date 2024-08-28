import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ManageSubjectDiolog extends StatelessWidget {
  bool isAddDiolog;
  ManageSubjectDiolog({super.key, this.isAddDiolog = true});

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isAddDiolog ? "Add Subject" : "Edit Subject"),
      content: TextField(
        controller: nameController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText:
              isAddDiolog ? "Enter name subject" : "Enter new name subject",
          label: const Text("Name"),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (nameController.text.trim().isNotEmpty) {
              Navigator.pop(context, nameController.text);
            }
          },
          child: Text(isAddDiolog ? "Add" : "Save"),
        ),
      ],
    );
  }
}
