import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.18获取电台歌曲[内部使用]
class GetRadioSongResponseModel extends BaseProtocol {
  List<CloudMusicMedia> songs;
  String resultCode;

  GetRadioSongResponseModel(Map json) : super(json) {
    if (arg['songs'] != null) {
      songs = <CloudMusicMedia>[];
      arg['songs'].forEach((v) {
        songs.add(new CloudMusicMedia.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
  }
  get songsCount => songs.length;
  CloudMusicMedia songsAtIndex(int index) {
    return songs[index];
  }
}
