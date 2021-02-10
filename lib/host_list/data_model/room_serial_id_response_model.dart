import 'package:xj_music/broadcast/base_protocol.dart';

//房间串口ID
class RoomSerialIdResponseModel extends BaseProtocol {
  String resultCode;
  String serialId;

  RoomSerialIdResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    serialId = arg['serialId'].toString();
  }
}
