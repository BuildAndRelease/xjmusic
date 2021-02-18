import 'package:xj_music/broadcast/base_protocol.dart';

import 'get_netradio_toplist_response_model.dart';

class GetNetFmCategoryListResponseModel extends BaseProtocol {
  List topRadios;
  List localRadios;
  List categories;

  GetNetFmCategoryListResponseModel(Map json) : super(json) {
    topRadios = arg['topRadios'];
    localRadios = arg['localRadios'];
    categories = arg['categories'];
  }

  get topListCount => topRadios?.length ?? 0;
  NetFmTopInfo topListAtIndex(int index) {
    return NetFmTopInfo.fromJson(topRadios[index]);
  }

  get categoryListCount => categories?.length ?? 0;
  NetFmCategoryInfo categoryListAtIndex(int index) {
    return NetFmCategoryInfo.fromJson(categories[index]);
  }
}

class NetFmCategoryInfo {
  String id;
  String name;

  NetFmCategoryInfo({this.id, this.name});

  NetFmCategoryInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
