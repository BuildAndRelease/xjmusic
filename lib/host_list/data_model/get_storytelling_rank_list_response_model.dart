//5.2.5获取排行榜
import 'package:xj_music/broadcast/base_protocol.dart';

class GetStoryTellingTopListResponseModel extends BaseProtocol {
  List rankingList;

  GetStoryTellingTopListResponseModel(Map json) : super(json) {
    rankingList = arg['rankingList'];
  }
  get storytellingTopListCount => rankingList.length;

  StoryTellingGroupTopItem storytellingTopListAtIndex(int index) {
    return StoryTellingGroupTopItem.fromJson(rankingList[index]);
  }
}

class StoryTellingGroupTopItem {
  List<StorytellingRankItem> list;
  String cateItemName;

  StoryTellingGroupTopItem({this.list, this.cateItemName});

  StoryTellingGroupTopItem.fromJson(Map json) {
    if (json['list'] != null) {
      list = <StorytellingRankItem>[];
      json['list'].forEach((v) {
        list.add(new StorytellingRankItem.fromJson(v));
      });
    }
    cateItemName = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['title'] = this.cateItemName;
    return data;
  }

  get listCount => list?.length ?? 0;

  StorytellingRankItem listAtIndex(int index) {
    return list[index];
  }
}

class StorytellingRankItem {
  String albumSetTypeName;
  String title;
  String categoryId;
  String subtitle;
  String calcPeriod;
  String orderNum;
  String contentType;
  String pic;
  String rankingListId;
  String top;
  List<StorytellingRankAlbumList> firstKResults;

  StorytellingRankItem(
      {this.albumSetTypeName,
      this.title,
      this.categoryId,
      this.subtitle,
      this.calcPeriod,
      this.orderNum,
      this.contentType,
      this.pic,
      this.rankingListId,
      this.top,
      this.firstKResults});

  StorytellingRankItem.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    title = json['title'].toString();
    categoryId = json['categoryId'].toString();
    subtitle = json['subtitle'].toString();
    calcPeriod = json['calcPeriod'].toString();
    orderNum = json['orderNum'].toString();
    contentType = json['contentType'].toString();
    pic = json['pic'].toString();
    rankingListId = json['rankingListId'].toString();
    top = json['top'].toString();
    if (json['firstKResults'] != null) {
      firstKResults = <StorytellingRankAlbumList>[];
      json['firstKResults'].forEach((v) {
        firstKResults.add(new StorytellingRankAlbumList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['title'] = this.title;
    data['categoryId'] = this.categoryId;
    data['subtitle'] = this.subtitle;
    data['calcPeriod'] = this.calcPeriod;
    data['orderNum'] = this.orderNum;
    data['contentType'] = this.contentType;
    data['pic'] = this.pic;
    data['rankingListId'] = this.rankingListId;
    data['top'] = this.top;
    if (this.firstKResults != null) {
      data['firstKResults'] =
          this.firstKResults.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get songListCount => firstKResults?.length ?? 0;
  StorytellingRankAlbumList songListAtIndex(int index) {
    return firstKResults[index];
  }
}

class StorytellingRankAlbumList {
  String id;
  String title;
  String contentType;

  StorytellingRankAlbumList({this.id, this.title, this.contentType});

  StorytellingRankAlbumList.fromJson(Map json) {
    id = json['id'].toString();
    title = json['title'].toString();
    contentType = json['contentType'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['contentType'] = this.contentType;
    return data;
  }
}
