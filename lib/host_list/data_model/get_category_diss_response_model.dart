import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.9获取分类下的歌单
class GetCategoryDissResponseModel extends BaseProtocol {
  List<DissSet> list;
  String pagenum;
  String perpage;
  String resultCode;
  String sort;
  String tagId;
  String total;

  GetCategoryDissResponseModel(Map json) : super(json) {
    if (json['list'] != null) {
      list = <DissSet>[];
      json['list'].forEach((v) {
        list.add(new DissSet.fromJson(v));
      });
    }
    pagenum = json['pagenum'].toString();
    perpage = json['perpage'].toString();
    resultCode = json['resultCode'].toString();
    sort = json['sort'].toString();
    tagId = json['tagid'].toString();
    total = json['total'].toString();
  }

  get listCount => list.length;

  DissSet listAtIndex(int index) {
    return list[index];
  }
}

class DissSet {
  String albumSetTypeName;
  String creatorName;
  String ctime;
  String dissPic;
  String dissname;
  String disstid;
  String scoreavage;
  String songnum;
  String visitnum;

  DissSet(
      {this.albumSetTypeName,
      this.creatorName,
      this.ctime,
      this.dissPic,
      this.dissname,
      this.disstid,
      this.scoreavage,
      this.songnum,
      this.visitnum});

  DissSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    creatorName = json['creatorName'].toString();
    ctime = json['ctime'].toString();
    dissPic = json['dissPic'].toString();
    dissname = json['dissname'].toString();
    disstid = json['disstid'].toString();
    scoreavage = json['scoreavage'].toString();
    songnum = json['songnum'].toString();
    visitnum = json['visitnum'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['creatorName'] = this.creatorName;
    data['ctime'] = this.ctime;
    data['dissPic'] = this.dissPic;
    data['dissname'] = this.dissname;
    data['disstid'] = this.disstid;
    data['scoreavage'] = this.scoreavage;
    data['songnum'] = this.songnum;
    data['visitnum'] = this.visitnum;
    return data;
  }
}
