import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.5获取排行榜
class GetTopListResponseModel extends BaseProtocol {
  List topListCate;

  GetTopListResponseModel(Map json) : super(json) {
    topListCate = arg['TopListCate'];
  }
  get topListCateCount => topListCate.length;

  TopItem topListCateAtIndex(int index) {
    return TopItem.fromJson(topListCate[index]);
  }
}

class TopItem {
  List<Item> list;
  String cateItemName;

  TopItem({this.list, this.cateItemName});

  TopItem.fromJson(Map json) {
    if (json['List'] != null) {
      list = <Item>[];
      json['List'].forEach((v) {
        list.add(new Item.fromJson(v));
      });
    }
    cateItemName = json['cateItemName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['List'] = this.list.map((v) => v.toJson()).toList();
    }
    data['cateItemName'] = this.cateItemName;
    return data;
  }

  get listCount => list?.length ?? 0;

  Item listAtIndex(int index) {
    return list[index];
  }
}

class Item {
  String albumSetTypeName;
  String date;
  String id;
  String name;
  String picurl;
  List<SongList> songList;

  Item(
      {this.albumSetTypeName,
      this.date,
      this.id,
      this.name,
      this.picurl,
      this.songList});

  Item.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    date = json['date'].toString();
    id = json['id'].toString();
    name = json['name'].toString();
    picurl = json['picurl'].toString();
    if (json['songList'] != null) {
      songList = <SongList>[];
      json['songList'].forEach((v) {
        songList.add(new SongList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['date'] = this.date;
    data['id'] = this.id;
    data['name'] = this.name;
    data['picurl'] = this.picurl;
    if (this.songList != null) {
      data['songList'] = this.songList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get songListCount => songList.length;
  SongList songListAtIndex(int index) {
    return songList[index];
  }
}

class SongList {
  String no;
  String singer;
  String song;

  SongList({this.no, this.singer, this.song});

  SongList.fromJson(Map json) {
    no = json['no'].toString();
    singer = json['singer'].toString();
    song = json['song'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['singer'] = this.singer;
    data['song'] = this.song;
    return data;
  }
}
