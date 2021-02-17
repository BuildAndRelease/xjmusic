import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_diss_list_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_diss_song_list_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_multi_select_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_radio_list_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_singer_list_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_singer_song_list_page.dart';
import 'package:xj_music/cloud_music/ui/cloud_music_top_song_list_page.dart';
import 'package:xj_music/local_media/ui/local_album_favorite_info_page.dart';
import 'package:xj_music/local_media/ui/local_music_category_page.dart';
import 'package:xj_music/main_page/room_main_page.dart';
import 'package:xj_music/main_page/room_player_playlist_page.dart';
import 'package:xj_music/net_radio/ui/netradio_list_page.dart';
import 'package:xj_music/story/ui/storytelling_anchor_album_page.dart';
import 'package:xj_music/story/ui/storytelling_anchor_list_page.dart';
import 'package:xj_music/story/ui/storytelling_category_album_page.dart';
import 'package:xj_music/story/ui/storytelling_category_page.dart';
import 'package:xj_music/story/ui/storytelling_toplist_album_page.dart';
import 'package:xj_music/story/ui/storytelling_toplist_page.dart';

import 'cloud_music/ui/cloud_music_album_list_page.dart';
import 'cloud_music/ui/cloud_music_album_song_page.dart';
import 'cloud_music/ui/cloud_music_newsong_page.dart';
import 'cloud_music/ui/cloud_music_top_list_page.dart';
import 'host_list/data_model/get_story_telling_category_response_model.dart';
import 'host_list/ui/host_list.dart';
import 'local_media/ui/local_album_favorite_list_page.dart';
import 'local_media/ui/local_music_favorite_playlist_manage_page.dart';
import 'local_media/ui/local_music_recent_play_page.dart';
import 'local_media/ui/local_music_subcategory_page.dart';
import 'main_page/room_player_info_page.dart';
import 'splash_page.dart';
import 'story/ui/storytelling_song_list_page.dart';
import 'util/custom_route.dart';
import 'util/global.dart';

const String homeRoute = "home";

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
    return push(context, RoomMainPage(), "roomMainPage", fadeIn: true);
  }

  static Future pushRoomPlayerInfoPage(BuildContext context) {
    return push(context, RoomPlayerInfoPage(), "roomPlayInfoPage");
  }

  static Future pushLocalMusicCategoryPage(BuildContext context) {
    return push(context, LocalMusicCategoryPage(), "localMusicCategoryPage",
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

  static Future pushCloudMusicMultiSelectPage(
      BuildContext context, List medias) {
    return push(context, CloudMusicMultiSelectPage(medias: medias),
        "cloudMusicMultiSelectPage");
  }

  static Future pushLocalMusicSubCategoryPage(BuildContext context,
      {String dir = "/", String head, String title, String subTitle}) {
    return push(context, LocalMusicSubCategoryPage(dir, head, title, subTitle),
        "localMusicSubCategoryPage",
        fadeIn: true);
  }

  static Future pushRecentPlayPage(BuildContext context) {
    return push(
        context, LocalMusicRecentPlayPage(), "localMusicRecentPlayPage");
  }

  static Future pushAlbumPage(BuildContext context) {
    return push(context, CloudMusicAlbumListPage(), "CloudMusicAlbumListPage");
  }

  static Future pushAlbumSongPage(
      BuildContext context, String albumMid, String title, String subTitle) {
    return push(context, CloudMusicAlbumSongPage(albumMid, title, subTitle),
        "cloudMusicAlbumSongPage");
  }

  static Future pushTopListPage(BuildContext context) {
    return push(context, CloudMusicTopListPage(), "CloudMusicTopListPage");
  }

  static Future pushTopSongPage(BuildContext context, String topListDate,
      String topListId, String topListName, String topPic) {
    return push(
        context,
        CloudMusicTopSongListPage(topListDate, topListId, topListName, topPic),
        "CloudMusicTopSongListPage");
  }

  static Future pushSingerListPage(BuildContext context) {
    return push(
        context, CloudMusicSingerListPage(), "CloudMusicSingerListPage");
  }

  static Future pushSingerSongListPage(BuildContext context, String singerMid,
      String singerName, String singerOtherName, String singerPic) {
    return push(
        context,
        CloudMusicSingerSongListPage(
            singerMid, singerName, singerOtherName, singerPic),
        "CloudMusicSingerSongListPage");
  }

  static Future pushDissListPage(BuildContext context) {
    return push(context, CloudMusicDissListPage(), "CloudMusicDissListPage");
  }

  static Future pushDissSongListPage(BuildContext context, String dissId,
      String dissName, String dissInfo, String dissPic) {
    return push(
        context,
        CloudMusicDissSongListPage(dissId, dissName, dissInfo, dissPic),
        "CloudMusicSingerSongListPage");
  }

  static Future pushRadioListPage(BuildContext context) {
    return push(context, CloudMusicRadioListPage(), "CloudMusicRadioListPage");
  }

  static Future pushStoryTellingSongListPage(BuildContext context,
      String albumId, String albumName, String albumInfo, String albumImg) {
    return push(
        context,
        StoryTellingSongListPage(albumId, albumName, albumInfo, albumImg),
        "StoryTellingSongListPage");
  }

  static Future pushStoryTellingAnchorListPage(BuildContext context) {
    return push(
        context, StorytellingAnchorListPage(), "StorytellingAnchorListPage");
  }

  static Future pushStoryTellingAnchorAlbumListPage(
      BuildContext context, String anchorId) {
    return push(context, StorytellingAnchorAlbumPage(anchorId),
        "StorytellingAnchorAlbumPage");
  }

  static Future pushStoryTellingCategoryListPage(BuildContext context) {
    return push(
        context, StorytellingCategoryPage(), "StorytellingCategoryPage");
  }

  static Future pushStoryTellingCategoryAlbumListPage(
      BuildContext context, Category category) {
    return push(context, StorytellingCategoryAlbumPage(category),
        "StorytellingCategoryAlbumPage");
  }

  static Future pushStoryTellingTopListPage(BuildContext context) {
    return push(context, StorytellingToplistPage(), "StorytellingToplistPage");
  }

  static Future pushStoryTellingTopAlbumListPage(
      BuildContext context, String topId) {
    return push(context, StorytellingTopListAlbumPage(topId),
        "StorytellingTopListAlbumPage");
  }

  static Future pushNetRadioListPage(BuildContext context, String categoryId) {
    return push(context, NetRadioListPage(categoryId), "NetRadioListPage");
  }

  static void backHome() {
    Global.navigatorKey.currentState
        .popUntil((route) => route.settings.name == homeRoute);
  }
}
