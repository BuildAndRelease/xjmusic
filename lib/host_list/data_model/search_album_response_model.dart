import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.24搜索专辑
class SearchAlbumResponseModel extends BaseProtocol {
  String curNum;
  String curPage;
  String keyword;
  List<AlbumItem> list;
  String resultCode;
  String totalNum;

  SearchAlbumResponseModel(Map json) : super(json) {
    curNum = json['curNum'];
    curPage = json['curPage'];
    keyword = json['keyword'];
    if (json['list'] != null) {
      list = <AlbumItem>[];
      json['list'].forEach((v) {
        list.add(new AlbumItem.fromJson(v));
      });
    }
    resultCode = json['resultCode'];
    totalNum = json['totalNum'];
  }

  get listCount => list.length;
  AlbumItem listAtIndex(int index) {
    return list[index];
  }
}

class AlbumItem {
  String albumId;
  String albumMid;
  String albumName;
  String albumSetTypeName;
  String picUrl;
  String publicTime;
  String singerId;
  String singerMid;
  String singerName;

  AlbumItem(
      {this.albumId,
      this.albumMid,
      this.albumName,
      this.albumSetTypeName,
      this.picUrl,
      this.publicTime,
      this.singerId,
      this.singerMid,
      this.singerName});

  AlbumItem.fromJson(Map json) {
    albumId = json['albumId'].toString();
    albumMid = json['albumMid'].toString();
    albumName = json['albumName'].toString();
    albumSetTypeName = json['albumSetTypeName'].toString();
    picUrl = json['pic_url'].toString();
    publicTime = json['publicTime'].toString();
    singerId = json['singerId'].toString();
    singerMid = json['singerMid'].toString();
    singerName = json['singerName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['albumMid'] = this.albumMid;
    data['albumName'] = this.albumName;
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['pic_url'] = this.picUrl;
    data['publicTime'] = this.publicTime;
    data['singerId'] = this.singerId;
    data['singerMid'] = this.singerMid;
    data['singerName'] = this.singerName;
    return data;
  }
}
