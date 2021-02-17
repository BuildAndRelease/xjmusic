import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_favorite_set_response_model.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.3.4获取语言节目的播放列表
class GetStorytellingPlaylistResponseModel extends BaseProtocol {
  List<CloudStoryTellingMedia> mediaPlayList;
  String resultCode;
  String total;

  GetStorytellingPlaylistResponseModel(Map json) : super(json) {
    if (arg['mediaPlayList'] != null) {
      mediaPlayList = <CloudStoryTellingMedia>[];
      arg['mediaPlayList'].forEach((v) {
        mediaPlayList.add(new CloudStoryTellingMedia.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
    total = arg['total'].toString();
  }
  get mediaPlayListCount => mediaPlayList?.length ?? 0;
  CloudStoryTellingMedia mediaPlayListAtIndex(int index) {
    return mediaPlayList[index];
  }

  void combineMoreData(GetStorytellingPlaylistResponseModel dataModle) {
    mediaPlayList.addAll(dataModle.mediaPlayList);
  }
}

class GetStorytellingAlumlistResponseModel extends BaseProtocol {
  List<StoryTellingAlbumSet> albumList;
  String resultCode;
  String total;

  GetStorytellingAlumlistResponseModel(Map json) : super(json) {
    if (arg['mediaList'] != null) {
      albumList = <StoryTellingAlbumSet>[];
      arg['mediaList'].forEach((v) {
        albumList.add(new StoryTellingAlbumSet.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
    total = arg['total'].toString();
  }
  get albumListCount => albumList?.length ?? 0;
  StoryTellingAlbumSet albumListAtIndex(int index) {
    return albumList[index];
  }

  void combineMoreData(GetStorytellingAlumlistResponseModel dataModle) {
    albumList.addAll(dataModle.albumList);
  }
}
