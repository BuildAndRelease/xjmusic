import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.16获取专辑下的歌曲
class GetAlbumSongResponseModel extends BaseProtocol {
  String aDate;
  String albumId;
  String albumMid;
  String albumName;
  String company;
  String curSongNum;
  String desc;
  List<CloudMusicMedia> list;
  String picUrl2;
  String resultCode;
  String songBegin;
  String totalSongNum;

  GetAlbumSongResponseModel(Map json) : super(json) {
    aDate = arg['aDate'].toString();
    albumId = arg['albumId'].toString();
    albumMid = arg['albumMid'].toString();
    albumName = arg['albumName'].toString();
    company = arg['company'].toString();
    curSongNum = arg['cur_song_num'].toString();
    desc = arg['desc'].toString();
    if (arg['list'] != null) {
      list = <CloudMusicMedia>[];
      json['list'].forEach((v) {
        list.add(new CloudMusicMedia.fromJson(v));
      });
    }
    picUrl2 = arg['pic_url2'].toString();
    resultCode = arg['resultCode'].toString();
    songBegin = arg['song_begin'].toString();
    totalSongNum = arg['total_song_num'].toString();
  }
  get listCount => list.length;
  CloudMusicMedia listAtIndex(int index) {
    return list[index];
  }
}
