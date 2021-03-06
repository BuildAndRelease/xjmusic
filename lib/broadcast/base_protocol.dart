class BaseProtocol {
  Map json;
  String sendId;
  String recvId;
  String cmd;
  String direction;
  Map arg = {};
  Object tag;

  BaseProtocol(Map json) {
    if (json == null) return;
    this.json = json;
    sendId = json["sendId"];
    recvId = json["recvId"];
    cmd = json["cmd"];
    direction = json["direction"];
    final argJson = json["arg"];
    if (argJson != null && argJson is Map) {
      arg = argJson;
    } else {
      arg = {};
    }
  }
}
