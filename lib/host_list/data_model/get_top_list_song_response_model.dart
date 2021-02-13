import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.6获取排行榜的歌曲
class GetTopListSongResponseModel extends BaseProtocol {
  List list;
  String totalSongNum;
  String updateTime;

  GetTopListSongResponseModel(Map json) : super(json) {
    list = arg['list'];
    totalSongNum = json['total_song_num'].toString();
    updateTime = json['update_time'].toString();
  }
  get listCount => list.length;

  CloudMusicMedia listAtIndex(int index) {
    return CloudMusicMedia.fromJson(list[index]);
  }
}
