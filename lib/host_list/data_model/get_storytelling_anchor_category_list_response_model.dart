//5.3.1获取语言节目的分类
import 'package:xj_music/broadcast/base_protocol.dart';

class GetStorytellingAnchorCategoryResponseModel extends BaseProtocol {
  List<StorytellingAnchorCategory> categoryList;
  String resultCode;

  GetStorytellingAnchorCategoryResponseModel(Map json) : super(json) {
    if (arg['mediaList'] != null) {
      categoryList = <StorytellingAnchorCategory>[];
      arg['mediaList'].forEach((v) {
        categoryList.add(new StorytellingAnchorCategory.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
  }
  get categoryListCount => (categoryList?.length ?? 0);
  StorytellingAnchorCategory categoryListAtIndex(int index) {
    return categoryList[index];
  }
}

class StorytellingAnchorCategory {
  String type;
  String id;
  String title;
  String name;

  StorytellingAnchorCategory({this.type, this.id, this.title, this.name});

  StorytellingAnchorCategory.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    id = json['id'].toString();
    title = json['title'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    return data;
  }
}
