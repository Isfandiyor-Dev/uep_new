// import 'package:flutter/material.dart';
// import 'package:uep/ui/admin/pages/users/users_tabs/admins_page.dart';
// import 'package:uep/ui/admin/pages/groups/group_page.dart';
// import 'package:uep/ui/admin/pages/users/users_tabs/students_page.dart';
// import 'package:uep/ui/admin/pages/users/users_tabs/teachers_page.dart';
// import 'package:uep/ui/admin/pages/working_day_page.dart';

// class AdminDrawer extends StatelessWidget {
//   const AdminDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'Menu',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           ListTile(
//             title: const Text('Studets'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const StudentsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text('Theachers'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const TeachersPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text('Admins'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const AdminsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text('Groups'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const GroupsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: const Text('Working Day'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const WorkingDaysPage(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
