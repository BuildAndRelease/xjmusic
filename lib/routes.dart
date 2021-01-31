import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'host_list/ui/host_list.dart';
import 'splash_page.dart';
import 'util/custom_route.dart';
import 'util/global.dart';

const String homeRoute = "home";
const String loginRoute = "login";
const String consoleRoute = "console";
const String createChannelRoute = "createChannel";
const String videoRoomRoute = "videoRoom";
const String videoRoomTextRoute = "videoRoomText";
const String personalRoute = "personal";
const String modifyUserInfoRoute = "modifyUserInfo";
const String loginCaptchaRoute = "loginCaptcha";
const String privacySetRoute = "privacySet";
const String shieldSetRoute = "shieldSet";
const String reportSetRoute = "reportSet";
const String suggestFeedbackRoute = "suggestFeedback";
const String aboutUsRoute = "aboutUs";
const String notifySetRoute = "notifySet";
const String loginModifyUserInfoRoute = "loginModifyUserInfo";
const String acceptInviteRoute = "acceptInvite";
const String createGuildRoute = "createGuild";
const String joinGuildRoute = "joinGuild";
const String invalidInviteRoute = "invalidInvite";
const String videoPage = "videoPage";
const String commonGuildRoute = "commonGuild";
const String commonFriendRoute = "commonFriend";
const String topicRoute = "topic";
const String quickReplyRoute = "quickReply";
const String quickReplyEditRoute = "quickReplyEdit";
const String guildSettingRoute = "guildSetting";
const String roleManageRoute = "roleManage";
const String roleSettingRoute = "roleSetting";
const String memberManageRoute = "memberManage";
const String memberManageInviteRoute = "memberManageInvite";
const String memberSettingRoute = "memberSetting";
const String channelManageRoute = "channelManage";
const String channelSettingRoute = "channelSetting";
const String channelPermissionRoute = "channelPermission";
const String addOverwriteRoute = "addOverwrite";
const String guildManageRoute = "guildManage";
const String createChannelCateRoute = "createChannelCate";
const String guildModifyRoute = "guildModify";
const String htmlRoute = "html";
const String countryRoute = "country";
const String pinListRoute = "pinList";

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

  static void backHome() {
    Global.navigatorKey.currentState
        .popUntil((route) => route.settings.name == homeRoute);
  }
}
