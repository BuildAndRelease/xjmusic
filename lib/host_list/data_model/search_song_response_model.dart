import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.23搜索歌曲
class SearchSongResponseModel extends BaseProtocol {
  String curNum;
  String curPage;
  String keyword;
  List<CloudMusicMedia> list;
  String resultCode;
  String totalNum;

  SearchSongResponseModel(Map json) : super(json) {
    curNum = json['curNum'].toString();
    curPage = json['curPage'].toString();
    keyword = json['keyword'].toString();
    if (json['list'] != null) {
      list = <CloudMusicMedia>[];
      json['list'].forEach((v) {
        list.add(new CloudMusicMedia.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    totalNum = json['totalNum'].toString();
  }

  get listCount => list.length;
  CloudMusicMedia listAtIndex(int index) {
    return list[index];
  }
}
