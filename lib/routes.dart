import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xj_music/local_media/ui/local_music_category_page.dart';
import 'package:xj_music/main_page/room_main_page.dart';

import 'host_list/ui/host_list.dart';
import 'splash_page.dart';
import 'util/custom_route.dart';
import 'util/global.dart';

const String homeRoute = "home";
const String roomMainPageRoute = "roomMainPage";
const String localMusicCategoryPageRoute = "localMusicCategoryPage";

class Routes {
  static String currentRoute;
  static String previousRoute;

  static Future push(BuildContext context, Widget page, String name,
      {bool replace, bool fullScreenDialog = false, bool fadeIn = false}) {
    previousRoute = currentRoute;
    currentRoute = name;
    if (replace == true) {
      return Global.navigatorKey.currentState.pushReplacement(
        fadeIn
            ? CustomRoute(
                page,
                settings: RouteSettings(name: name),
              )
            : MaterialPageRoute(
                builder: (_) => page,
                settings: RouteSettings(name: name),
                fullscreenDialog: fullScreenDialog),
      );
    } else {
      return Global.navigatorKey.currentState.push(
        MaterialPageRoute(
            builder: (_) => page,
            settings: RouteSettings(name: name),
            fullscreenDialog: fullScreenDialog),
      );
    }
  }

  static void pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static Widget showLaunchPage() {
    return SplashPage();
  }

  static Future pushHomePage(BuildContext context) async {
    return push(context, HostListPage(), homeRoute,
        replace: true, fadeIn: true);
  }

  static Future pushRoomMainPage(BuildContext context) {
    return push(context, RoomMainPage(), roomMainPageRoute, fadeIn: true);
  }

  static Future pushLocalMusicCategoryPage(BuildContext context) {
    return push(context, LocalMusicCategoryPage(), localMusicCategoryPageRoute,
        fadeIn: true);
  }

  static void backHome() {
    Global.navigatorKey.currentState
        .popUntil((route) => route.settings.name == homeRoute);
  }
}
