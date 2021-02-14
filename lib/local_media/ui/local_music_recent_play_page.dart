import 'package:flutter/material.dart';
import 'package:xj_music/local_media/ui/local_music_cloud_recent_play.dart';
import 'package:xj_music/local_media/ui/local_music_local_recent_play.dart';
import 'package:xj_music/local_media/ui/local_music_storytelling_recent_play.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class LocalMusicRecentPlayPage extends StatefulWidget {
  @override
  _LocalMusicRecentPlayPageState createState() =>
      _LocalMusicRecentPlayPageState();
}

class _LocalMusicRecentPlayPageState extends State<LocalMusicRecentPlayPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = <Tab>[];
  List<Widget> _tabViews = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupTabViews();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.white,
          onPressed: () {
            Routes.pop(context);
          },
        ),
        title: Text(
          "最近播放",
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.3),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.transparent,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _tabViews),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  void _setupTabViews() {
    _tabViews.clear();
    _tabViews.add(LocalMusicCloudRecentPlayPage());
    _tabViews.add(LocalMusicStoryTellingRecentPlayPage());
    _tabViews.add(LocalMusicLocalRecentPlayPage());

    _tabs.clear();
    _tabs.add(_tabBarItem("云音乐"));
    _tabs.add(_tabBarItem("语言节目"));
    _tabs.add(_tabBarItem("本地音乐"));

    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);

    _tabController.removeListener(_updateTabViews);
    _tabController.addListener(_updateTabViews);
  }

  void _updateTabViews() {
    // _tabViews[_tabController.index].scrollable.value = true;
    // _tabViews[_tabController.previousIndex].scrollable.value = false;
  }

  Widget _tabBarItem(String title) {
    return Tab(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sizeHeight8,
        Text(title),
        sizeHeight8,
      ],
    ));
  }
}
