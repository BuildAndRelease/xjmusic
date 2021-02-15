import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';
import 'package:xj_music/util/const.dart';

class MusicUIFrame extends StatefulWidget {
  final String headTitle;
  final String title;
  final String subTitle;
  final String imageUrl;
  final bool playBtnEnable;
  final bool addBtnEnable;
  final bool multiSelectBtnEnable;
  final Function() onPlayAll;
  final Function() onAddCollection;
  final Function() onMultiSelect;
  final int Function() itemCount;
  final double itemHeight;
  final Widget Function(BuildContext context, int index) widgetAtIndex;
  final bool refreshEnable;
  final bool loadMoreEnable;
  final void Function() onRefresh;
  final void Function() onLoadMore;
  final RefreshController refreshController;

  const MusicUIFrame(
      {this.headTitle,
      this.title,
      this.subTitle,
      this.imageUrl,
      this.playBtnEnable = false,
      this.addBtnEnable = false,
      this.multiSelectBtnEnable = false,
      this.onPlayAll,
      this.onMultiSelect,
      this.onAddCollection,
      this.itemHeight,
      @required this.itemCount,
      @required this.widgetAtIndex,
      this.loadMoreEnable,
      this.onLoadMore,
      this.refreshEnable,
      this.onRefresh,
      @required this.refreshController});

  @override
  _MusicUIFrameState createState() => _MusicUIFrameState();
}

class _MusicUIFrameState extends State<MusicUIFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                widget.headTitle ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
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
            )
          ];
        },
        body: SmartRefresher(
          enablePullDown: widget.refreshEnable,
          enablePullUp: widget.loadMoreEnable,
          controller: widget.refreshController,
          onRefresh: widget.onRefresh?.call,
          onLoading: widget.onLoadMore?.call,
          child: ListView.builder(
            itemExtent: widget.itemHeight,
            itemCount: widget.itemCount?.call() ?? 0,
            itemBuilder: (context, index) =>
                widget.widgetAtIndex?.call(context, index) ?? const SizedBox(),
          ),
        ),
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Widget _buildHeaderbackground() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: widget.imageUrl ?? defaultIcon,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.black.withOpacity(0.2),
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
                      fadeInDuration: Duration.zero,
                      imageUrl: widget.imageUrl ?? defaultIcon,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                      imageBuilder: (_, image) {
                        return Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: image, fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        );
                      }),
                  sizeWidth16,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        widget.subTitle ?? "",
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () =>
                        widget.playBtnEnable ? widget.onPlayAll?.call() : null,
                    icon: Icon(
                      Icons.play_circle_outline_sharp,
                      size: 30,
                      color:
                          widget.playBtnEnable ? Colors.white : Colors.white38,
                    ),
                  ),
                  IconButton(
                    onPressed: () => widget.addBtnEnable
                        ? widget.onAddCollection?.call()
                        : null,
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
                    onPressed: () => widget.multiSelectBtnEnable
                        ? widget.onMultiSelect?.call()
                        : null,
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
