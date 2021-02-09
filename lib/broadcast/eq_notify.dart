import 'package:xj_music/broadcast/base_protocol.dart';

//4.8.3音效更改通知
class EqNotify extends BaseProtocol {
  String eq;

  EqNotify(Map json) : super(json) {
    eq = arg["eq"].toString();
  }
}
