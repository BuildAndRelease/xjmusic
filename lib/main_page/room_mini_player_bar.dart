import 'package:flutter/material.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/avatar.dart';

class RoomMiniPlayerBar extends StatefulWidget {
  @override
  _RoomMiniPlayerBarState createState() => _RoomMiniPlayerBarState();
}

class _RoomMiniPlayerBarState extends State<RoomMiniPlayerBar>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMusicBar();
  }

  Widget _buildMusicBar() {
    final _showSubTitle = false;
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 0.5),
          if (!_showSubTitle) sizeHeight8,
          ListTile(
            leading: RotationTransition(
              turns: _controller,
              child: Avatar(
                  url:
                      "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg",
                  radius: 24),
            ),
            title: Text("歌曲"),
            subtitle: _showSubTitle ? Text("歌手") : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_circle_outline_sharp,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.format_list_bulleted,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          if (!_showSubTitle) sizeHeight8,
        ],
      ),
    );
  }
}
