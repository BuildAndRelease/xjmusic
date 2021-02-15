import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.15获取专辑
class GetAlbumResponseModel extends BaseProtocol {
  List<AlumItem> list;
  String order;
  String pageNum;
  String perPage;
  String resultCode;
  String total;

  GetAlbumResponseModel(Map json) : super(json) {
    if (arg['list'] != null) {
      list = <AlumItem>[];
      arg['list'].forEach((v) {
        list.add(new AlumItem.fromJson(v));
      });
    }
    order = arg['order'].toString();
    pageNum = arg['pageNum'].toString();
    perPage = arg['per_page'].toString();
    resultCode = arg['resultCode'].toString();
    total = arg['total'].toString();
  }
  get listCount => list.length;

  AlumItem listAtIndex(int index) {
    return list[index];
  }

  void combineMoreData(GetAlbumResponseModel dataModel) {
    list.addAll(dataModel.list);
  }
}

class AlumItem {
  String albumSetTypeName;
  String albumMID;
  String area;
  String genre;
  String id;
  String index;
  String language;
  String name;
  String picUrl;
  String pubTime;
  String singerArea;
  String singerId;
  String singerMid;
  String singerName;
  String singerOtherName;
  String singerType;
  String songNum;

  AlumItem(
      {this.albumSetTypeName,
      this.albumMID,
      this.area,
      this.genre,
      this.id,
      this.index,
      this.language,
      this.name,
      this.picUrl,
      this.pubTime,
      this.singerArea,
      this.singerId,
      this.singerMid,
      this.singerName,
      this.singerOtherName,
      this.singerType,
      this.songNum});

  AlumItem.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    albumMID = json['albumMID'].toString();
    area = json['area'].toString();
    genre = json['genre'].toString();
    id = json['id'].toString();
    index = json['index'].toString();
    language = json['language'].toString();
    name = json['name'].toString();
    picUrl = json['pic_url'].toString();
    pubTime = json['pub_time'].toString();
    singerArea = json['singer_area'].toString();
    singerId = json['singer_id'].toString();
    singerMid = json['singer_mid'].toString();
    singerName = json['singer_name'].toString();
    singerOtherName = json['singer_other_name'].toString();
    singerType = json['singer_type'].toString();
    songNum = json['song_num'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['albumMID'] = this.albumMID;
    data['area'] = this.area;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['index'] = this.index;
    data['language'] = this.language;
    data['name'] = this.name;
    data['pic_url'] = this.picUrl;
    data['pub_time'] = this.pubTime;
    data['singer_area'] = this.singerArea;
    data['singer_id'] = this.singerId;
    data['singer_mid'] = this.singerMid;
    data['singer_name'] = this.singerName;
    data['singer_other_name'] = this.singerOtherName;
    data['singer_type'] = this.singerType;
    data['song_num'] = this.songNum;
    return data;
  }
}
