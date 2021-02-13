import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.22搜索歌词
class SearchLyricResponseModel extends BaseProtocol {
  String curNum;
  String curPage;
  String keyword;
  List<Item> list;
  String resultCode;
  String totalNum;

  SearchLyricResponseModel(Map json) : super(json) {
    curNum = json['curNum'].toString();
    curPage = json['curPage'].toString();
    keyword = json['keyword'].toString();
    if (json['list'] != null) {
      list = <Item>[];
      json['list'].forEach((v) {
        list.add(new Item.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    totalNum = json['totalNum'].toString();
  }

  get listCount => list.length;
  Item listAtIndex(int index) {
    return list[index];
  }
}

class Item {
  String albumId;
  String albumMid;
  String albumName;
  String content;
  String duration;
  String lyric;
  String mediaSrc;
  String picUrl;
  String pubTime;
  List<Singer> singer;
  String songId;
  String songMid;
  String songName;

  Item(
      {this.albumId,
      this.albumMid,
      this.albumName,
      this.content,
      this.duration,
      this.lyric,
      this.mediaSrc,
      this.picUrl,
      this.pubTime,
      this.singer,
      this.songId,
      this.songMid,
      this.songName});

  Item.fromJson(Map json) {
    albumId = json['albumId'].toString();
    albumMid = json['albumMid'].toString();
    albumName = json['albumName'].toString();
    content = json['content'].toString();
    duration = json['duration'].toString();
    lyric = json['lyric'].toString();
    mediaSrc = json['mediaSrc'].toString();
    picUrl = json['picUrl'].toString();
    pubTime = json['pubTime'].toString();
    if (json['singer'] != null) {
      singer = <Singer>[];
      json['singer'].forEach((v) {
        singer.add(new Singer.fromJson(v));
      });
    }
    songId = json['songId'].toString();
    songMid = json['songMid'].toString();
    songName = json['songName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['albumMid'] = this.albumMid;
    data['albumName'] = this.albumName;
    data['content'] = this.content;
    data['duration'] = this.duration;
    data['lyric'] = this.lyric;
    data['mediaSrc'] = this.mediaSrc;
    data['picUrl'] = this.picUrl;
    data['pubTime'] = this.pubTime;
    if (this.singer != null) {
      data['singer'] = this.singer.map((v) => v.toJson()).toList();
    }
    data['songId'] = this.songId;
    data['songMid'] = this.songMid;
    data['songName'] = this.songName;
    return data;
  }

  get singerCount => singer.length;
  Singer singerAtIndex(int index) {
    return singer[index];
  }
}

class Singer {
  String id;
  String mid;
  String name;

  Singer({this.id, this.mid, this.name});

  Singer.fromJson(Map json) {
    id = json['id'].toString();
    mid = json['mid'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    return data;
  }
}
