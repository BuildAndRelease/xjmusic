import 'package:xj_music/broadcast/base_protocol.dart';

//5.2.12获取指定歌单分类下的歌单
class GetDissResponseModel extends BaseProtocol {
  String categoryId;
  String ein;
  List<Diss> list;
  String resultCode;
  String sin;
  String sortId;
  String sum;

  GetDissResponseModel(Map json) : super(json) {
    categoryId = json['categoryId'].toString();
    ein = json['ein'].toString();
    if (json['list'] != null) {
      list = <Diss>[];
      json['list'].forEach((v) {
        list.add(new Diss.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    sin = json['sin'].toString();
    sortId = json['sortId'].toString();
    sum = json['sum'].toString();
  }

  get listCount => list.length;
  Diss listAtIndex(int index) {
    return list[index];
  }
}

class Diss {
  String albumSetTypeName;
  String createTime;
  String createrName;
  String dissId;
  String dissName;
  String imgUrl;
  String introduction;
  String listenNum;
  String score;

  Diss(
      {this.albumSetTypeName,
      this.createTime,
      this.createrName,
      this.dissId,
      this.dissName,
      this.imgUrl,
      this.introduction,
      this.listenNum,
      this.score});

  Diss.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    createTime = json['createTime'].toString();
    createrName = json['createrName'].toString();
    dissId = json['dissId'].toString();
    dissName = json['dissName'].toString();
    imgUrl = json['imgUrl'].toString();
    introduction = json['introduction'].toString();
    listenNum = json['listenNum'].toString();
    score = json['score'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = this.albumSetTypeName;
    data['createTime'] = this.createTime;
    data['createrName'] = this.createrName;
    data['dissId'] = this.dissId;
    data['dissName'] = this.dissName;
    data['imgUrl'] = this.imgUrl;
    data['introduction'] = this.introduction;
    data['listenNum'] = this.listenNum;
    data['score'] = this.score;
    return data;
  }
}
