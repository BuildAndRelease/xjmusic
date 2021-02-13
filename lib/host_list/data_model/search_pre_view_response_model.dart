import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.21搜索提示
class SearchPreViewResponseModel extends BaseProtocol {
  Resource album;
  String resultCode;
  Resource singer;
  Resource song;

  SearchPreViewResponseModel(Map json) : super(json) {
    album = json['album'] != null ? new Resource.fromJson(json['album']) : null;
    resultCode = json['resultCode'].toString();
    singer =
        json['singer'] != null ? new Resource.fromJson(json['singer']) : null;
    song = json['song'] != null ? new Resource.fromJson(json['song']) : null;
  }
}

class Resource {
  String count;
  List<AbsItem> itemList;
  String name;
  String order;
  String type;

  Resource({this.count, this.itemList, this.name, this.order, this.type});

  Resource.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    itemList = [];

    if (json['itemList'] != null) {
      if (json['itemList']["albummid"] == null) {
        json['itemList'].forEach((v) {
          itemList.add(Item.fromJson(v));
        });
      } else {
        json['itemList'].forEach((v) {
          itemList.add(Song.fromJson(v));
        });
      }
    }
    name = json['name'];
    order = json['order'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['order'] = this.order;
    data['type'] = this.type;
    return data;
  }
}

abstract class AbsItem {
  String docid;
  String id;
  String mid;
  String name;
  String singer;
  Map<String, dynamic> toJson();
}

class Item extends AbsItem {
  String pic;

  Item({docid, id, mid, name, this.pic, singer});

  Item.fromJson(Map json) {
    docid = json['docid'].toString();
    id = json['id'].toString();
    mid = json['mid'].toString();
    name = json['name'].toString();
    pic = json['pic'].toString();
    singer = json['singer'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docid'] = this.docid;
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['pic'] = this.pic;
    data['singer'] = this.singer;
    return data;
  }
}

class Song extends AbsItem {
  String albummid;

  Song({this.albummid, docid, id, mid, name, singer});

  Song.fromJson(Map json) {
    albummid = json['albummid'].toString();
    docid = json['docid'].toString();
    id = json['id'].toString();
    mid = json['mid'].toString();
    name = json['name'].toString();
    singer = json['singer'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albummid'] = this.albummid;
    data['docid'] = this.docid;
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['singer'] = this.singer;
    return data;
  }
}
