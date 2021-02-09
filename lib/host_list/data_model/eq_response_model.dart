import 'package:xj_music/broadcast/base_protocol.dart';

//4.8.1获取音效
class EqResponseModel extends BaseProtocol {
  String resultCode;
  String eq;

  EqResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    eq = arg['eq'].toString();
  }
}
