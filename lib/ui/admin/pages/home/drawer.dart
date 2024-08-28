import 'package:flutter/material.dart';
import 'package:uep/ui/admin/pages/home/tiles_drawer/subjects/subjects.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Subjects(),
                ),
              );
            },
            title: const Text("Subjects"),
          ),
        ],
      ),
    );
  }
}
