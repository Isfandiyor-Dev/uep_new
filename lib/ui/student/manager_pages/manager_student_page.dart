import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uep/ui/global_screens/profile/profile_page.dart';
import 'package:uep/ui/student/home/home_student_page.dart';
import 'package:uep/ui/student/my_group/my_groups_page.dart';

class ManageStudentPage extends StatefulWidget {
  const ManageStudentPage({super.key});

  @override
  State<ManageStudentPage> createState() => _ManageStudentPageState();
}

class _ManageStudentPageState extends State<ManageStudentPage> {
  int currentItem = 0;

  List<Widget> pages = [
    const HomeStudentPage(),
    const MyGroupsPage(),
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
