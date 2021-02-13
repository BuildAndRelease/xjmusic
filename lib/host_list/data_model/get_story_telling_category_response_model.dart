import 'package:xj_music/broadcast/base_protocol.dart';

//5.3.1获取语言节目的分类
class GetStorytellingCategoryResponseModel extends BaseProtocol {
  List<Category> categoryList;
  String resultCode;

  GetStorytellingCategoryResponseModel(Map json) : super(json) {
    if (json['categoryList'] != null) {
      categoryList = <Category>[];
      json['categoryList'].forEach((v) {
        categoryList.add(new Category.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
  }
  get categoryListCount => categoryList.length;
  Category categoryListAtIndex(int index) {
    return categoryList[index];
  }
}

class Category {
  String categoryName;
  String id;
  String parentId;
  List<SubCategory> subCategoryList;

  Category({this.categoryName, this.id, this.parentId, this.subCategoryList});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'].toString();
    id = json['id'].toString();
    parentId = json['parentId'].toString();
    if (json['subCategoryList'] != null) {
      subCategoryList = <SubCategory>[];
      json['subCategoryList'].forEach((v) {
        subCategoryList.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    if (this.subCategoryList != null) {
      data['subCategoryList'] =
          this.subCategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get subCategoryListCount => subCategoryList.length;
  SubCategory subCategoryListAtIndex(int index) {
    return subCategoryList[index];
  }
}

class SubCategory {
  String categoryName;
  String id;
  String parentId;

  SubCategory({this.categoryName, this.id, this.parentId});

  SubCategory.fromJson(Map json) {
    categoryName = json['categoryName'].toString();
    id = json['id'].toString();
    parentId = json['parentId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    return data;
  }
}
