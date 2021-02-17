import 'package:xj_music/broadcast/base_protocol.dart';

//5.3.3获取语言节目的专辑信息（根据专辑ID）
class GetStorytellingAlbumInfoResponseModel extends BaseProtocol {
  String resultCode;
  Map album;
  Map tracks;

  GetStorytellingAlbumInfoResponseModel(Map json) : super(json) {
    resultCode = json['resultCode'].toString();
    album = json['album'];
    tracks = json['tracks'];
  }
}
