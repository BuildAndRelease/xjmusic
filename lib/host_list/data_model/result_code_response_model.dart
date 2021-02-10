import 'package:xj_music/broadcast/base_protocol.dart';

//结果码
class ResultCodeResponseModel extends BaseProtocol {
  String resultCode;

  ResultCodeResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
  }
}
