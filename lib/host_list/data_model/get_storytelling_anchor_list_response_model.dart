import 'package:xj_music/broadcast/base_protocol.dart';

class GetStorytellingAnchorListResponseModel extends BaseProtocol {
  List<StorytellingAnchorInfo> categoryList;
  String resultCode;

  GetStorytellingAnchorListResponseModel(Map json) : super(json) {
    if (arg['mediaList'] != null) {
      categoryList = <StorytellingAnchorInfo>[];
      arg['mediaList'].forEach((v) {
        categoryList.add(new StorytellingAnchorInfo.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
  }
  get categoryListCount => (categoryList?.length ?? 0);
  StorytellingAnchorInfo categoryListAtIndex(int index) {
    return categoryList[index];
  }

  void combineMoreData(GetStorytellingAnchorListResponseModel dataModel) {
    categoryList.addAll(dataModel.categoryList ?? []);
  }
}

class StorytellingAnchorInfo {
  String uid;
  String isVerified;
  String albumSetTypeName;
  String personDescribe;
  String followersCounts;
  String tracksCounts;
  String nickname;
  String verifyTitle;
  String pic;

  StorytellingAnchorInfo(
      {this.uid,
      this.isVerified,
      this.albumSetTypeName,
      this.personDescribe,
      this.followersCounts,
      this.tracksCounts,
      this.nickname,
      this.verifyTitle,
      this.pic});

  StorytellingAnchorInfo.fromJson(Map<String, dynamic> json) {
    uid = json['uid'].toString();
    isVerified = json['isVerified'].toString();
    albumSetTypeName = json['albumSetTypeName'].toString();
    personDescribe = json['personDescribe'].toString();
    followersCounts = json['followersCounts'].toString();
    tracksCounts = json['tracksCounts'].toString();
    nickname = json['nickname'].toString();
    verifyTitle = json['verifyTitle'].toString();
    pic = json['pic'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['isVerified'] = this.isVerified;
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['personDescribe'] = this.personDescribe;
    data['followersCounts'] = this.followersCounts;
    data['tracksCounts'] = this.tracksCounts;
    data['nickname'] = this.nickname;
    data['verifyTitle'] = this.verifyTitle;
    data['pic'] = this.pic;
    return data;
  }
}
