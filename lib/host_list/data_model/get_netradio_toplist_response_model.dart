//5.2.5获取排行榜
import 'package:xj_music/broadcast/base_protocol.dart';

class GetNetFmTopListResponseModel extends BaseProtocol {
  List topList;

  GetNetFmTopListResponseModel(Map json) : super(json) {
    topList = arg['list'];
  }
  get topListCateCount => topList?.length ?? 0;

  NetFmTopInfo topListCateAtIndex(int index) {
    return NetFmTopInfo.fromJson(topList[index]);
  }
}

class NetFmTopInfo {
  String id;
  String mediaSrc;
  String picUrl;
  String programId;
  String playCount;
  String programScheduleId;
  String fmUid;
  String name;
  String playUrl1;
  String playUrl2;
  String programName;

  NetFmTopInfo(
      {this.id,
      this.mediaSrc,
      this.picUrl,
      this.programId,
      this.playCount,
      this.programScheduleId,
      this.fmUid,
      this.name,
      this.playUrl1,
      this.playUrl2,
      this.programName});

  NetFmTopInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    mediaSrc = json['mediaSrc'].toString();
    picUrl = json['picUrl'].toString();
    programId = json['programId'].toString();
    playCount = json['playCount'].toString();
    programScheduleId = json['programScheduleId'].toString();
    fmUid = json['fmUid'].toString();
    name = json['name'].toString();
    playUrl1 = json['playUrl1'].toString();
    playUrl2 = json['playUrl2'].toString();
    programName = json['programName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mediaSrc'] = this.mediaSrc;
    data['picUrl'] = this.picUrl;
    data['programId'] = this.programId;
    data['playCount'] = this.playCount;
    data['programScheduleId'] = this.programScheduleId;
    data['fmUid'] = this.fmUid;
    data['name'] = this.name;
    data['playUrl1'] = this.playUrl1;
    data['playUrl2'] = this.playUrl2;
    data['programName'] = this.programName;
    return data;
  }
}
