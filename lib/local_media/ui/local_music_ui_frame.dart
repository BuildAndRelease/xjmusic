import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class LocalMusicUIFrame extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool playBtnEnable;
  final bool addBtnEnable;
  final bool multiSelectBtnEnable;
  final int Function() itemCount;
  final Widget Function(BuildContext context, int index) widgetAtIndex;

  const LocalMusicUIFrame(
      {this.title,
      this.subTitle,
      this.playBtnEnable = false,
      this.addBtnEnable = false,
      this.multiSelectBtnEnable = false,
      @required this.itemCount,
      @required this.widgetAtIndex});

  @override
  _LocalMusicUIFrameState createState() => _LocalMusicUIFrameState();
}

class _LocalMusicUIFrameState extends State<LocalMusicUIFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.title ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24,
              color: Colors.white,
              onPressed: () {
                Routes.pop(context);
              },
            ),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            expandedHeight: 204.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: _buildHeaderbackground(),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 56.5,
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  widget.widgetAtIndex?.call(context, index) ??
                  const SizedBox(),
              childCount: widget.itemCount?.call() ?? 0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Widget _buildHeaderbackground() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2279879648,475318368&fm=26&gp=0.jpg",
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  sizeWidth16,
                  Text(
                    widget.subTitle ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_circle_outline_sharp,
                      size: 30,
                      color:
                          widget.playBtnEnable ? Colors.white : Colors.white38,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color:
                          widget.addBtnEnable ? Colors.white : Colors.white38,
                    ),
                  ),
                  Expanded(
                    child: Text(""),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.playlist_add_check_outlined,
                      size: 30,
                      color: widget.multiSelectBtnEnable
                          ? Colors.white
                          : Colors.white38,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
