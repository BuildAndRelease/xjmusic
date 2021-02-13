import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.20获取热门推荐
class GetRecommendResponseModel extends BaseProtocol {
  Album album;
  List<Diss> diss;
  String resultCode;
  List<Yinyueren> yinyueren;

  GetRecommendResponseModel(Map json) : super(json) {
    album = arg['album'] != null ? new Album.fromJson(arg['album']) : null;
    if (arg['diss'] != null) {
      diss = <Diss>[];
      arg['diss'].forEach((v) {
        diss.add(new Diss.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
    if (arg['yinyueren'] != null) {
      yinyueren = <Yinyueren>[];
      arg['yinyueren'].forEach((v) {
        yinyueren.add(new Yinyueren.fromJson(v));
      });
    }
  }
  get dissCount => diss.length;
  Diss dissAtIndex(int index) {
    return diss[index];
  }

  get yinyuerenCount => yinyueren.length;
  Yinyueren yinyuerenAtIndex(int index) {
    return yinyueren[index];
  }
}

class Album {
  List<Cn> cn;
  List eu;
  List extra;
  List gt;
  List j;
  List k;
  List nd;
  List news;

  Album(
      {this.cn,
      this.eu,
      this.extra,
      this.gt,
      this.j,
      this.k,
      this.nd,
      this.news});

  Album.fromJson(Map json) {
    if (json['cn'] != null) {
      cn = <Cn>[];
      json['cn'].forEach((v) {
        cn.add(new Cn.fromJson(v));
      });
    }
    eu = json['eu'];
    extra = json['extra'];
    gt = json['gt'];
    j = json['j'];
    k = json['k'];
    nd = json['nd'];
    news = json['new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cn != null) {
      data['cn'] = this.cn.map((v) => v.toJson()).toList();
    }
    data['eu'] = this.eu;
    data['extra'] = this.extra;
    data['gt'] = this.gt;
    data['j'] = this.j;
    data['k'] = this.k;
    data['nd'] = this.nd;
    data['new'] = this.news;
    return data;
  }
}

class Cn {
  String albumID;
  String albumMID;
  String albumName;
  String albumSetTypeName;
  String area;
  String language;
  String picUrl;
  String score;
  String singerId;
  String singerMId;
  String singerName;

  Cn(
      {this.albumID,
      this.albumMID,
      this.albumName,
      this.albumSetTypeName,
      this.area,
      this.language,
      this.picUrl,
      this.score,
      this.singerId,
      this.singerMId,
      this.singerName});

  Cn.fromJson(Map json) {
    albumID = json['albumID'].toString();
    albumMID = json['albumMID'].toString();
    albumName = json['albumName'].toString();
    albumSetTypeName = json['albumSetTypeName'].toString();
    area = json['area'].toString();
    language = json['language'].toString();
    picUrl = json['pic_url'].toString();
    score = json['score'].toString();
    singerId = json['singerId'].toString();
    singerMId = json['singerMId'].toString();
    singerName = json['singerName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumID'] = this.albumID;
    data['albumMID'] = this.albumMID;
    data['albumName'] = this.albumName;
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['area'] = this.area;
    data['language'] = this.language;
    data['pic_url'] = this.picUrl;
    data['score'] = this.score;
    data['singerId'] = this.singerId;
    data['singerMId'] = this.singerMId;
    data['singerName'] = this.singerName;
    return data;
  }
}

class Diss {
  String name;
  String recommendList;

  Diss({this.name, this.recommendList});

  Diss.fromJson(Map json) {
    name = json['name'].toString();
    recommendList = json['recommendList'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['recommendList'] = this.recommendList;
    return data;
  }
}

class Yinyueren {
  String desc;
  String genres;
  String picurl;
  String singerid;
  String singermid;
  String singername;

  Yinyueren(
      {this.desc,
      this.genres,
      this.picurl,
      this.singerid,
      this.singermid,
      this.singername});

  Yinyueren.fromJson(Map json) {
    desc = json['desc'].toString();
    genres = json['genres'].toString();
    picurl = json['picurl'].toString();
    singerid = json['singerid'].toString();
    singermid = json['singermid'].toString();
    singername = json['singername'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['genres'] = this.genres;
    data['picurl'] = this.picurl;
    data['singerid'] = this.singerid;
    data['singermid'] = this.singermid;
    data['singername'] = this.singername;
    return data;
  }
}
