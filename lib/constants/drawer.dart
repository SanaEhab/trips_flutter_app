import 'package:flutter/material.dart';
import 'package:trips_flutter_app/constants/drawer_List.dart';

class MyDrawer extends StatelessWidget {

  final void Function()? onProfile;
  const MyDrawer({super.key, required this.onProfile});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child:Column(
        children: [
          const DrawerHeader(
              child: Icon(Icons.travel_explore_rounded,
                  color: Colors.white,
                  size: 64)
          ),
          const SizedBox(
            height: 100.0,
          ),
          DrawerList(
            icon: Icons.home,
            text: 'H O M E',
            onTap: ()=> Navigator.pop(context),
          ),
          DrawerList(
            icon: Icons.person,
            text: 'P R O F I L E',
            onTap: onProfile,
          ),
        ],
      ),
    );
  }
}
