import 'package:flutter/material.dart';
import 'package:uep/ui/admin/pages/settings/working_day_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkingDaysPage(),
                  ));
            },
            leading: Icon(Icons.watch_later_rounded),
            title: Text("Working Day"),
          ),
        ],
      ),
    );
  }
}
