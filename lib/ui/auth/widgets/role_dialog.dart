import 'package:flutter/material.dart';

class RoleDialog extends StatefulWidget {
  const RoleDialog({super.key});

  @override
  State<RoleDialog> createState() => _RoleDialogState();
}

class _RoleDialogState extends State<RoleDialog> {
  int? roleId = 1;

  String getRole() {
    switch (roleId) {
      case 1:
        return "Student";
      case 2:
        return "Teacher";
      case 3:
        return "Admin";
      default:
        return "Choose Your Role";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Your Role"),
      content: DropdownButtonFormField<int>(
        value: roleId,
        decoration: const InputDecoration(
          labelText: 'Choose Your Role',
          border: OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text("Student"),
          ),
          DropdownMenuItem(
            value: 2,
            child: Text("Teacher"),
          ),
          DropdownMenuItem(
            value: 3,
            child: Text("Admin"),
          ),
        ],
        onChanged: (value) {
          setState(() {
            roleId = value;
          });
        },
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context, roleId);
          },
          child: const Text("Next"),
        ),
      ],
    );
  }
}
