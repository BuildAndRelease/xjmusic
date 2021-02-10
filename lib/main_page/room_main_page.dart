import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:xj_music/data_center/data_center.dart';
import 'package:xj_music/cloud_music/ui/room_main_cloudmusic_fragment.dart';
import 'package:xj_music/local_media/ui/room_main_local_fragment.dart';
import 'package:xj_music/net_radio/ui/room_main_netradio_fragment.dart';
import 'package:xj_music/main_page/room_main_setting_drawer.dart';
import 'package:xj_music/story/ui/room_main_story_fragment.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

import 'room_mini_player_bar.dart';

class RoomMainPage extends StatefulWidget {
  @override
  _RoomMainPageState createState() => _RoomMainPageState();
}

class _RoomMainPageState extends State<RoomMainPage>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> _tabs = <Tab>[];
  List<Widget> _tabViews = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setupTabViews();
    return Scaffold(
      endDrawer: Container(
        width: 250,
        child: Drawer(
          child: RoomMainSettingDrawer(),
        ),
      ),
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
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 24,
            color: Colors.white,
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                iconSize: 24,
                color: Colors.white,
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              );
            },
          )
        ],
        title: Text(
          DataCenter.instance.currentRoomName ??
              DataCenter.instance.deviceModelWithDeviceId(),
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
    _tabViews.add(RoomMainLocalFragment());
    _tabViews.add(RoomMainCloudMusicFragment());
    _tabViews.add(RoomMainStoryFragment());
    _tabViews.add(RoomMainNetRadioFragment());

    _tabs.clear();
    _tabs.add(_tabBarItem(Icons.computer));
    _tabs.add(_tabBarItem(Icons.cloud_queue));
    _tabs.add(_tabBarItem(Icons.graphic_eq));
    _tabs.add(_tabBarItem(Octicons.radio_tower));

    _tabController =
        TabController(initialIndex: 1, length: _tabs.length, vsync: this);

    _tabController.removeListener(_updateTabViews);
    _tabController.addListener(_updateTabViews);
  }

  void _updateTabViews() {
    // _tabViews[_tabController.index].scrollable.value = true;
    // _tabViews[_tabController.previousIndex].scrollable.value = false;
  }

  Widget _tabBarItem(IconData iconData) {
    return Tab(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        sizeHeight8,
        Icon(
          iconData,
          size: 20,
        ),
        sizeHeight8,
      ],
    ));
  }
}
