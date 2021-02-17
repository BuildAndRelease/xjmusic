import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_story_telling_play_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/host_list/data_model/story_telling_response_model.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class RoomMainStoryFragment extends StatefulWidget {
  @override
  _RoomMainStoryFragmentState createState() => _RoomMainStoryFragmentState();
}

class _RoomMainStoryFragmentState extends State<RoomMainStoryFragment> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetStorytellingAlumlistResponseModel _recommendResponseModel;

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];
    for (var i = 0;
        i < min((_recommendResponseModel?.albumListCount ?? 0), 9);
        i++) {
      final dataModel = _recommendResponseModel?.albumListAtIndex(i);
      widgets.add(_buildRecommendAlbum(dataModel.mediaName,
          dataModel.description, utf8.decode(base64.decode(dataModel.pic)), () {
        Routes.pushStoryTellingSongListPage(
            context,
            dataModel.id,
            dataModel.mediaName,
            dataModel.description,
            utf8.decode(base64Decode(dataModel.pic)));
      }));
    }
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _onRefresh,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMusicCategoryIconButton(
                      Typicons.th_large_outline, "分类", () => print("object")),
                  _buildMusicCategoryIconButton(
                      FontAwesome.sellsy, "榜单", () => print("object")),
                  _buildMusicCategoryIconButton(
                      Typicons.user_outline, "主播", () => print("object")),
                ],
              ),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              GestureDetector(
                onTap: () => Routes.pushAlbumPage(context),
                child: Text("热门推荐 >"),
              ),
              sizeHeight8,
              Wrap(
                spacing: 5,
                alignment: WrapAlignment.spaceAround,
                runSpacing: 5,
                children: widgets,
              ),
              sizeHeight8,
            ],
          ),
        ));
  }

  Widget _buildRecommendAlbum(
      String title, String subTitle, String imageUrl, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
              fadeInDuration: Duration.zero,
              imageUrl: imageUrl,
              width: 120,
              height: 120,
              imageBuilder: (_, image) {
                return Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                );
              }),
          SizedBox(
            width: 120,
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              subTitle,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicCategoryIconButton(
      IconData icon, String title, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          sizeHeight8,
          Text(title),
        ],
      ),
    );
  }

  void _onRefresh() {
    HostApi.getStorytellingPush(
      "1",
      "10",
      "recommend",
      onError: (error) {
        showToast("获取专辑列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        _recommendResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
    );
  }
}
