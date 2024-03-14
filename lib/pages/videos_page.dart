import 'package:flutter/material.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Videos"),
      ),
      // body: ListView.builder(
      //   itemBuilder: (context, index) {},
      // ),
    );
  }
}
