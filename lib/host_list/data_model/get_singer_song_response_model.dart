import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.2获取歌手的歌曲
class GetSingerSongResponseModel extends BaseProtocol {
  String begin;
  List list;
  String order;
  String perPage;
  String total;

  GetSingerSongResponseModel(Map json) : super(json) {
    begin = arg['begin'].toString();
    list = arg['list'];
    order = arg['order'].toString();
    perPage = arg['per_page'].toString();
    total = arg['total'].toString();
  }
  get listCount => list?.length ?? 0;

  CloudMusicMedia listAtIndex(int index) {
    return CloudMusicMedia.fromJson(list[index]);
  }

  void combineMoreData(GetSingerSongResponseModel dataModel) {
    list.addAll(dataModel.list);
  }
}
