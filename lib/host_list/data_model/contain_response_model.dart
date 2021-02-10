import 'package:xj_music/broadcast/base_protocol.dart';

//判断是否包含
class ContainResponseModel extends BaseProtocol {
  String resultCode;
  String contain;

  ContainResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    contain = arg['contain'].toString();
  }
}
