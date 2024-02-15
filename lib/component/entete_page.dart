import 'package:flutter/material.dart';


class EnteteAppBar extends StatelessWidget {
  const EnteteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("MUSIC_DJI"),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(
            Icons.menu,
            size: 40,
          ), // Icône du Drawer
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Icon(
            Icons.person,
            size: 30,
          ),
        )
      ],
    );
  }
}
