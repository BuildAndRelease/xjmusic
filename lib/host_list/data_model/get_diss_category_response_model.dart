import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.11获取歌单分类
class GetDissCategoryResponseModel extends BaseProtocol {
  List<CategorieGroup> categories;
  String resultCode;

  GetDissCategoryResponseModel(Map json) : super(json) {
    if (json['categories'] != null) {
      categories = <CategorieGroup>[];
      json['categories'].forEach((v) {
        categories.add(new CategorieGroup.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
  }
  get categoriesCount => categories.length;

  CategorieGroup categoriesAtIndex(int index) {
    return categories[index];
  }
}

class CategorieGroup {
  String categoryGroupName;
  List<Categorie> items;

  CategorieGroup({this.categoryGroupName, this.items});

  CategorieGroup.fromJson(Map json) {
    categoryGroupName = json['categoryGroupName'].toString();
    if (json['items'] != null) {
      items = <Categorie>[];
      json['items'].forEach((v) {
        items.add(new Categorie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryGroupName'] = this.categoryGroupName;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }

  get itemsCount => items.length;

  Categorie itemsAtIndex(int index) {
    return items[index];
  }
}

class Categorie {
  String categoryId;
  String categoryName;

  Categorie({this.categoryId, this.categoryName});

  Categorie.fromJson(Map json) {
    categoryId = json['categoryId'].toString();
    categoryName = json['categoryName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
