import 'package:xj_music/broadcast/base_protocol.dart';
import 'package:xj_music/host_list/data_model/get_playing_info_response_model.dart';

//5.2.19获取新歌速递
class GetNewSongResponseModel extends BaseProtocol {
  String area;
  List<Area> areaList;
  String resultCode;
  List<CloudMusicMedia> songList;
  int sum;

  GetNewSongResponseModel(Map json) : super(json) {
    area = arg['area'];
    if (arg['areaList'] != null) {
      areaList = <Area>[];
      arg['areaList'].forEach((v) {
        areaList.add(new Area.fromJson(v));
      });
    }
    resultCode = arg['resultCode'].toString();
    if (arg['songList'] != null) {
      songList = <CloudMusicMedia>[];
      arg['songList'].forEach((v) {
        songList.add(new CloudMusicMedia.fromJson(v));
      });
    }
    sum = arg['sum'];
  }

  get areaListCount => areaList.length;
  Area areaListAtIndex(int index) {
    return areaList[index];
  }

  get songListCount => songList.length;
  CloudMusicMedia songListAtIndex(int index) {
    return songList[index];
  }
}

class Area {
  String area;
  String name;

  Area({this.area, this.name});

  Area.fromJson(Map json) {
    area = json['area'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area'] = this.area;
    data['name'] = this.name;
    return data;
  }
}
