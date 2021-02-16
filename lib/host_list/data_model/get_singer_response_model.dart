import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_favorite_set_response_model.dart';

//5.2.1获取歌手
class GetSingerResponseModel extends BaseProtocol {
  String category;
  String index;
  List list;
  String pageNo;
  String perPage;
  String total;

  GetSingerResponseModel(Map json) : super(json) {
    category = arg['category'].toString();
    index = arg['index'].toString();
    list = arg['list'];
    pageNo = arg['pageNo'].toString();
    perPage = arg['per_page'].toString();
    total = arg['total'].toString();
  }
  get listCount => list?.length ?? 0;

  CloudSingerSet listAtIndex(int index) {
    return CloudSingerSet.fromJson(list[index]);
  }

  void combineMoreData(GetSingerResponseModel dataModel) {
    list.addAll(dataModel.list);
  }
}
