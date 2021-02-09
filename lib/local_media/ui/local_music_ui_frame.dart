import 'package:flutter/material.dart';
import 'package:xj_music/routes.dart';

class LocalMusicUIFrame extends StatefulWidget {
  final String title;

  const LocalMusicUIFrame({this.title});

  @override
  _LocalMusicUIFrameState createState() => _LocalMusicUIFrameState();
}

class _LocalMusicUIFrameState extends State<LocalMusicUIFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            Routes.pop(context);
          },
        ),
        toolbarHeight: 150,
        flexibleSpace: Container(
          color: Colors.red,
          height: 150,
        ),
      ),
    );
  }
}
