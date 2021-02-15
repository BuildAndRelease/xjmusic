import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xj_music/local_media/ui/local_album_favorite_info_page.dart';
import 'package:xj_music/local_media/ui/local_music_category_page.dart';
import 'package:xj_music/main_page/room_main_page.dart';
import 'package:xj_music/main_page/room_player_playlist_page.dart';

import 'cloud_music/ui/cloud_music_newsong_page.dart';
import 'host_list/ui/host_list.dart';
import 'local_media/ui/local_album_favorite_list_page.dart';
import 'local_media/ui/local_music_favorite_playlist_manage_page.dart';
import 'local_media/ui/local_music_recent_play_page.dart';
import 'local_media/ui/local_music_subcategory_page.dart';
import 'main_page/room_player_info_page.dart';
import 'splash_page.dart';
import 'util/custom_route.dart';
import 'util/global.dart';

const String homeRoute = "home";
const String roomMainPageRoute = "roomMainPage";
const String roomPlayInfoPageRoute = "roomPlayInfoPage";
const String localMusicCategoryPageRoute = "localMusicCategoryPage";
const String localMusicSubCategoryPageRoute = "localMusicSubCategoryPage";

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

  static Future pushRoomPlayerInfoPage(BuildContext context) {
    return push(context, RoomPlayerInfoPage(), roomPlayInfoPageRoute);
  }

  static Future pushLocalMusicCategoryPage(BuildContext context) {
    return push(context, LocalMusicCategoryPage(), localMusicCategoryPageRoute,
        fadeIn: true);
  }

  static Future pushPlayListPage(BuildContext context) {
    return push(context, RoomPlayerPlayListPage(), "roomPlayerPlayListPage");
  }

  static Future pushAlbumFavoriteSetListPage(BuildContext context) {
    return push(
        context, LocalAlbumFavoriteListPage(), "localAlbumFavoriteSetListPage");
  }

  static Future pushAlbumFavoriteSetInfoPage(
      BuildContext context, String albumSetId) {
    return push(context, LocalAlbumFavoriteInfoPage(albumSetId),
        "localAlbumFavoriteSetInfoPage");
  }

  static Future pushLocalMusicFavoritePlayListPage(BuildContext context) {
    return push(context, LocalMusicFavoritePlaylistManagePage(),
        "localMusicFavoritePlaylistManagePage");
  }

  static Future pushCloudMusicNewSongPage(BuildContext context) {
    return push(context, CloudMusicNewSongPage(), "cloudMusicNewSongPage");
  }

  static Future pushLocalMusicSubCategoryPage(BuildContext context,
      {String dir = "/", String head, String title, String subTitle}) {
    return push(context, LocalMusicSubCategoryPage(dir, head, title, subTitle),
        localMusicSubCategoryPageRoute,
        fadeIn: true);
  }

  static Future pushRecentPlayPage(BuildContext context) {
    return push(
        context, LocalMusicRecentPlayPage(), "localMusicRecentPlayPage");
  }

  static void backHome() {
    Global.navigatorKey.currentState
        .popUntil((route) => route.settings.name == homeRoute);
  }
}
