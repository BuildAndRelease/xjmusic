import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.7获取分类
class GetCategoryResponseModel extends BaseProtocol {
  List categories;

  GetCategoryResponseModel(Map json) : super(json) {
    categories = arg['categories'];
  }
  get categoriesCount => categories.length;

  CategoryItem categoriesAtIndex(int index) {
    return CategoryItem.fromJson(categories[index]);
  }
}

class CategoryItem {
  String groupId;
  List<CategorySet> items;
  String title;

  CategoryItem({this.groupId, this.items, this.title});

  CategoryItem.fromJson(Map json) {
    groupId = json['group_id'].toString();
    if (json['items'] != null) {
      items = <CategorySet>[];
      json['items'].forEach((v) {
        items.add(new CategorySet.fromJson(v));
      });
    }
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }

  get itemsCount => items.length;

  CategorySet itemsAtIndex(int index) {
    return items[index];
  }
}

class CategorySet {
  String albumSetTypeName;
  String pic;
  String shortTitle;
  String tagAlbum;
  String tagAlbumType;
  String tagDiss;
  String tagDissType;
  String tagTrack;
  String tagTrackType;
  String tag_album;
  String tag_album_type;
  String tagId;
  String tagIntro;
  String title;

  CategorySet(
      {this.albumSetTypeName,
      this.pic,
      this.shortTitle,
      this.tagAlbum,
      this.tagAlbumType,
      this.tagDiss,
      this.tagDissType,
      this.tagTrack,
      this.tagTrackType,
      this.tag_album,
      this.tag_album_type,
      this.tagId,
      this.tagIntro,
      this.title});

  CategorySet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    pic = json['pic'].toString();
    shortTitle = json['short_title'].toString();
    tagAlbum = json['tagAlbum'].toString();
    tagAlbumType = json['tagAlbumType'].toString();
    tagDiss = json['tagDiss'].toString();
    tagDissType = json['tagDissType'].toString();
    tagTrack = json['tagTrack'].toString();
    tagTrackType = json['tagTrackType'].toString();
    tag_album = json['tag_album'].toString();
    tag_album_type = json['tag_album_type'].toString();
    tagId = json['tag_id'].toString();
    tagIntro = json['tag_intro'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['pic'] = this.pic;
    data['short_title'] = this.shortTitle;
    data['tagAlbum'] = this.tagAlbum;
    data['tagAlbumType'] = this.tagAlbumType;
    data['tagDiss'] = this.tagDiss;
    data['tagDissType'] = this.tagDissType;
    data['tagTrack'] = this.tagTrack;
    data['tagTrackType'] = this.tagTrackType;
    data['tag_album'] = this.tag_album;
    data['tag_album_type'] = this.tag_album_type;
    data['tag_id'] = this.tagId;
    data['tag_intro'] = this.tagIntro;
    data['title'] = this.title;
    return data;
  }
}
