import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_category_response_model.dart';
import 'package:xj_music/host_list/data_model/host_api.dart';
import 'package:xj_music/main_page/room_mini_player_bar.dart';
import 'package:xj_music/routes.dart';

class StorytellingCategoryPage extends StatefulWidget {
  @override
  _StorytellingCategoryPageState createState() =>
      _StorytellingCategoryPageState();
}

class _StorytellingCategoryPageState extends State<StorytellingCategoryPage> {
  GetStorytellingCategoryResponseModel _listResponseModel;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        title: Text(
          '分类',
          style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.white,
          onPressed: () {
            Routes.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 4 / 1.5),
              itemBuilder: (context, index) {
                final category = _listResponseModel.categoryListAtIndex(index);
                return GestureDetector(
                  onTap: () {
                    Routes.pushStoryTellingCategoryAlbumListPage(
                        context, category);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    alignment: Alignment.center,
                    child: Text(
                      category.categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
              itemCount: (_listResponseModel?.categoryListCount ?? 0),
            ),
          )),
        ],
      ),
      bottomNavigationBar: RoomMiniPlayerBar(),
    );
  }

  Future _onRefresh() async {
    HostApi.getStorytellingCategory(
      onResponse: (response) {
        _listResponseModel = response;
        _refreshController.refreshCompleted();
        if (mounted) setState(() {});
      },
      onError: (error) {
        showToast(error.toString());
        _refreshController.refreshFailed();
      },
    );
  }
}
