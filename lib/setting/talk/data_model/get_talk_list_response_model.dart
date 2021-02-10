import 'package:xj_music/broadcast/base_protocol.dart';

//4.24.1获取对讲组列表
class GetTalkListResponseModel extends BaseProtocol {
  String resultCode;
  List talkList;

  GetTalkListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    talkList = arg['talkList'];
  }

  get talkListCount => talkList.length;

  Talk talkListAtIndex(int index) {
    return Talk.fromJson(talkList[index]);
  }
}

class Talk {
  String talkName;
  String talkId;
  String talkStat;

  Talk({this.talkName, this.talkId, this.talkStat});

  Talk.fromJson(Map json) {
    talkName = json['talkName'].toString();
    talkId = json['talkId'].toString();
    talkStat = json['talkStat'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['talkName'] = this.talkName;
    data['talkId'] = this.talkId;
    data['talkStat'] = this.talkStat;
    return data;
  }
}
