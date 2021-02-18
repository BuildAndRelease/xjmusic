import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_netradio_category_list_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/routes.dart';
import 'package:xj_music/themes/const.dart';

class RoomMainNetRadioFragment extends StatefulWidget {
  @override
  _RoomMainNetRadioFragmentState createState() =>
      _RoomMainNetRadioFragmentState();
}

class _RoomMainNetRadioFragmentState extends State<RoomMainNetRadioFragment> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GetNetFmCategoryListResponseModel _categoryResponseModel;

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
    final List<Widget> categoryWidgets = [];
    for (var i = 0; i < (_categoryResponseModel?.categoryListCount ?? 0); i++) {
      final dataModel = _categoryResponseModel.categoryListAtIndex(i);
      categoryWidgets.add(Container(
          width: 70,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          alignment: Alignment.center,
          child: Text(dataModel.name, textAlign: TextAlign.center)));
    }
    final List<Widget> topWidgets = [];
    for (var i = 0;
        i < min(_categoryResponseModel?.topListCount ?? 0, 10);
        i++) {
      final dataModel = _categoryResponseModel?.topListAtIndex(i);
      topWidgets.add(_buildRecommendAlbum(
          dataModel.picUrl,
          dataModel.name,
          dataModel.programName,
          "${(double.tryParse(dataModel.playCount) / 10000.0).toStringAsPrecision(2)}万人在听",
          () {
        HostApi.playCloudNetFm(dataModel.toJson());
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
                  _buildMusicCategoryIconButton(Icons.location_on, "本地台",
                      () => Routes.pushTopListPage(context)),
                  _buildMusicCategoryIconButton(Icons.account_balance, "国家台",
                      () => Routes.pushSingerListPage(context)),
                  _buildMusicCategoryIconButton(FontAwesome5.building, "省市台",
                      () => Routes.pushDissListPage(context)),
                  _buildMusicCategoryIconButton(Icons.radio, "网络台",
                      () => Routes.pushRadioListPage(context)),
                ],
              ),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              Center(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: categoryWidgets,
                ),
              ),
              sizeHeight8,
              Divider(height: 0.5),
              sizeHeight8,
              GestureDetector(
                onTap: () => Routes.pushCloudMusicNewSongPage(context),
                child: Text("热门榜单 >"),
              ),
              ...topWidgets
            ],
          ),
        ));
  }

  Widget _buildRecommendAlbum(String pic, String title, String subTitle1,
      String subTitle2, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
              fadeInDuration: Duration.zero,
              imageUrl: pic,
              width: 100,
              height: 100,
              imageBuilder: (_, image) {
                return Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: image, fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                );
              }),
          SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeHeight8,
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                sizeHeight8,
                Text(
                  subTitle1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subTitle2,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Expanded(child: const SizedBox()),
          Icon(
            Icons.play_circle_outline,
            size: 30,
          ),
          sizeWidth8
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
    HostApi.getNetFmCategory(
      onError: (error) {
        showToast("获取榜单列表失败");
        _refreshController.refreshFailed();
      },
      onResponse: (response) {
        _categoryResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) {
          setState(() {});
        }
      },
    );
  }
}
