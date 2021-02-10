import 'package:xj_music/broadcast/base_protocol.dart';

//4.26.3设置房间串口ID[列表形式]
class SetRoomSerialIdListResponseModel extends BaseProtocol {
  String resultCode;
  List list;

  SetRoomSerialIdListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    list = arg['list'];
  }

  get listCount => list.length;

  Map listAtIndex(int index) {
    Map map = new Map();
    map["serialId"] = list[index]["serialId"];
    map["roomId"] = list[index]["roomId"];
    return map;
  }
}
