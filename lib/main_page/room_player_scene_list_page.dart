import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xj_music/setting/scene/data_model/get_scene_list_response_model.dart';
import 'package:xj_music/setting/scene/data_model/scene_api.dart';

class RoomPlayerSceneListPage extends StatefulWidget {
  @override
  _RoomPlayerSceneListPageState createState() =>
      _RoomPlayerSceneListPageState();
}

class _RoomPlayerSceneListPageState extends State<RoomPlayerSceneListPage> {
  ValueNotifier<GetSceneListResponseModel> _sceneListResponseModel =
      ValueNotifier(GetSceneListResponseModel({}));

  @override
  void initState() {
    SceneApi.getSceneList(
      onResponse: (response) {
        _sceneListResponseModel.value = response;
      },
      onError: (error) => showToast("获取场景列表失败"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("场景列表"),
      ),
      body: ValueListenableBuilder(
        valueListenable: _sceneListResponseModel,
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final scene = value.sceneListAtIndex(index);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    tileColor: Theme.of(context).backgroundColor,
                    leading: Icon(Icons.playlist_play),
                    title: Text(
                      scene.sceneName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    onTap: () {
                      SceneApi.executeScene(
                        scene.sceneId,
                        onError: (error) => showToast("场景执行失败"),
                        onResponse: (response) {
                          if (response.resultCode == "0") {
                            showToast("场景执行成功");
                            Navigator.of(context).pop();
                          } else {
                            showToast("场景执行失败");
                          }
                        },
                      );
                    },
                    trailing: Icon(Icons.play_arrow),
                  ),
                  Divider(
                    height: 0.5,
                  )
                ],
              );
            },
            itemCount: value.sceneListCount ?? 0,
          );
        },
      ),
    );
  }
}
