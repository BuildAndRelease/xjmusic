import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.3获取歌手的专辑
class GetSingerAlbumResponseModel extends BaseProtocol {
  String begin;
  List list;
  String order;
  String perPage;
  String total;
  String resultCode;

  GetSingerAlbumResponseModel(Map json) : super(json) {
    begin = arg['begin'].toString();
    list = arg['list'];
    order = arg['order'].toString();
    perPage = arg['per_page'].toString();
    total = arg['total'].toString();
    resultCode = arg['resultCode'].toString();
  }
  get listCount => list.length;

  Album listAtIndex(int index) {
    return Album.fromJson(list[index]);
  }
}

class Album {
  String albumSetTypeName;
  String albumId;
  String albumMid;
  String albumName;
  String company;
  String desc;
  String picUrl;
  String pubTime;
  String singerId;
  String singerMid;
  String singerName;

  Album(
      {this.albumSetTypeName,
      this.albumId,
      this.albumMid,
      this.albumName,
      this.company,
      this.desc,
      this.picUrl,
      this.pubTime,
      this.singerId,
      this.singerMid,
      this.singerName});

  Album.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    albumId = json['albumId'].toString();
    albumMid = json['albumMid'].toString();
    albumName = json['albumName'].toString();
    company = json['company'].toString();
    desc = json['desc'].toString();
    picUrl = json['pic_url'].toString();
    pubTime = json['pubTime'].toString();
    singerId = json['singerId'].toString();
    singerMid = json['singerMid'].toString();
    singerName = json['singerName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['albumId'] = this.albumId;
    data['albumMid'] = this.albumMid;
    data['albumName'] = this.albumName;
    data['company'] = this.company;
    data['desc'] = this.desc;
    data['pic_url'] = this.picUrl;
    data['pubTime'] = this.pubTime;
    data['singerId'] = this.singerId;
    data['singerMid'] = this.singerMid;
    data['singerName'] = this.singerName;
    return data;
  }
}
