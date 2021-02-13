import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.8获取分类下的歌曲
class GetCategorySongResponseModel extends BaseProtocol {
  List list;
  String pagenum;
  String perpage;
  String resultCode;
  String sort;
  String tagId;
  String total;

  GetCategorySongResponseModel(Map json) : super(json) {
    list = arg['list'];
    pagenum = json['pagenum'].toString();
    perpage = json['perpage'].toString();
    resultCode = json['resultCode'].toString();
    sort = json['sort'].toString();
    tagId = json['tagId'].toString();
    total = json['total'].toString();
  }
  get listCount => list.length;

  CloudMusicMedia listAtIndex(int index) {
    return CloudMusicMedia.fromJson(list[index]);
  }
}
