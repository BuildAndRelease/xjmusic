import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.17获取电台
class GetRadioResponseModel extends BaseProtocol {
  List<GroupList> groupList;
  String resultCode;

  GetRadioResponseModel(Map json) : super(json) {
    if (arg['groupList'] != null) {
      groupList = <GroupList>[];
      arg['groupList'].forEach((v) {
        groupList.add(new GroupList.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
  }
  get groupListCount => groupList.length;
  GroupList groupListAtIndex(int index) {
    return groupList[index];
  }
}

class GroupList {
  String categoryName;
  String name;
  List<RadioList> radioList;
  String type;

  GroupList({this.categoryName, this.name, this.radioList, this.type});

  GroupList.fromJson(Map json) {
    categoryName = json['categoryName'].toString();
    name = json['name'].toString();
    if (json['radioList'] != null) {
      radioList = <RadioList>[];
      json['radioList'].forEach((v) {
        radioList.add(new RadioList.fromJson(v));
      });
    }
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['name'] = this.name;
    if (this.radioList != null) {
      data['radioList'] = this.radioList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    return data;
  }

  get radioListCount => radioList.length;
  RadioList radioListAtIndex(int index) {
    return radioList[index];
  }
}

class RadioList {
  String albumSetTypeName;
  String listenNum;
  String radioId;
  String radioImg;
  String radioName;

  RadioList(
      {this.albumSetTypeName,
      this.listenNum,
      this.radioId,
      this.radioImg,
      this.radioName});

  RadioList.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    listenNum = json['listenNum'].toString();
    radioId = json['radioId'].toString();
    radioImg = json['radioImg'].toString();
    radioName = json['radioName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['listenNum'] = this.listenNum;
    data['radioId'] = this.radioId;
    data['radioImg'] = this.radioImg;
    data['radioName'] = this.radioName;
    return data;
  }
}
