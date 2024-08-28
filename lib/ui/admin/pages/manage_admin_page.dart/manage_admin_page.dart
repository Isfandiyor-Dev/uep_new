import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uep/ui/admin/pages/groups/group_page.dart';
import 'package:uep/ui/admin/pages/users/users_page.dart';
import 'package:uep/ui/admin/pages/home/home_admin_screen.dart';
import 'package:uep/ui/global_screens/profile/profile_page.dart';

class ManageAdminPage extends StatefulWidget {
  const ManageAdminPage({super.key});

  @override
  State<ManageAdminPage> createState() => _ManageAdminPageState();
}

class _ManageAdminPageState extends State<ManageAdminPage> {
  int currentItem = 0;
  List<Widget> pages = [
    const HomeAdminScreen(),
    const UsersPage(),
    const GroupsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_2_fill),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.group_solid),
            label: "Groups",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          setState(() {
            currentItem = value;
          });
        },
      ),
      body: pages[currentItem],
    );
  }
}
