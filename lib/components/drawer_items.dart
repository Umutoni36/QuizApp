import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:my_app/screens/calculator/contact_list.dart';
//import 'package:my_app/screens/calculator/gallery.dart';
//import 'package:my_app/screens/calculator/settings.dart';

class DrawerItems extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const DrawerItems({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Color.fromARGB(150, 33, 149, 243)),
          child: Text(
            ' 📱',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        // _buildListTile(
        //   title: 'Home',
        //   onTap: () {
        //     onItemSelected(0);
        //     Navigator.pop(context);
        //   },
        //   isSelected: selectedIndex == 0,
        // ),
        //_buildListTile(
        //  title: 'picture/camera',
        // onTap: () {
        //  Navigator.pop(context);
        //  Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const PickImage()));
        //},
        //isSelected: selectedIndex == 1,
        //),
        //_buildListTile(
        // title: 'Contact',
        // onTap: () {
        //   Navigator.pop(context);
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        // //          builder: (context) => const ContactListScreen()));
        // },
        // isSelected: selectedIndex == 2,
        //),
        //_buildListTile(
        //  title: 'Theme',
        //  onTap: () {
        //    Navigator.pop(context);
        //    Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const SettingsPage()),
        //   );
        // },
        //  isSelected: selectedIndex == 3,
        // ),
        // _buildListTile(
        //   title: 'Quiz',
        //   onTap: () {
        //     Navigator.pop(context);
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const QuizPage()),
        //     );
        //   },
        //   isSelected: selectedIndex == 4,
        // ),
        _buildListTile(
            title: 'Logout',
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            isSelected: selectedIndex == 5),
      ],
    );
  }

  Widget _buildListTile({
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return ListTile(
      title: Text(title),
      selected: isSelected,
      onTap: onTap,
    );
  }
}
