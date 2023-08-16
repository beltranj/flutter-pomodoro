import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 20,
      child: ListView(children: [
        ListTile(
          leading: Icon(Icons.settings),
        )
      ]),
    );
  }
}
