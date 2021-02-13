import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.13获取歌单下的歌曲
class GetDissSongResponseModel extends BaseProtocol {
  String creatorName;
  String ctime;
  String desc;
  String dissName;
  String dissPic;
  String disstId;
  List<CloudMusicMedia> list;
  String resultCode;
  String songNum;
  List<Tag> tags;

  GetDissSongResponseModel(Map json) : super(json) {
    creatorName = json['creatorName'].toString();
    ctime = json['ctime'].toString();
    desc = json['desc'].toString();
    dissName = json['dissName'].toString();
    dissPic = json['dissPic'].toString();
    disstId = json['disstId'].toString();

    if (json['list'] != null) {
      list = <CloudMusicMedia>[];
      json['list'].forEach((v) {
        list.add(new CloudMusicMedia.fromJson(v));
      });
    }
    resultCode = json['resultCode'].toString();
    songNum = json['songNum'].toString();

    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags.add(new Tag.fromJson(v));
      });
    }
  }
  get listCount => list.length;
  CloudMusicMedia listAtIndex(int index) {
    return list[index];
  }

  get tagsCount => tags.length;
  Tag tagsAtIndex(int index) {
    return tags[index];
  }
}

class Tag {
  String id;
  String name;

  Tag({this.id, this.name});

  Tag.fromJson(Map json) {
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
