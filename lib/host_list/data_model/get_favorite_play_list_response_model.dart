import 'package:xj_music/broadcast/base_protocol.dart';

//4.19.1获取自建歌单列表
class GetFavoritePlayListResponseModel extends BaseProtocol {
  String resultCode;
  List playLists;

  GetFavoritePlayListResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    playLists = arg['playList'];
  }

  get playListCount => playLists?.length ?? 0;

  PlayList playListsAtIndex(int index) {
    PlayList playList = PlayList.fromJson(playLists[index]);
    return playList;
  }
}

class PlayList {
  String playListId;
  String playListName;
  String editStat;

  PlayList({this.playListId, this.playListName, this.editStat});

  PlayList.fromJson(Map json) {
    playListId = json['playListId'].toString();
    playListName = json['playListName'].toString();
    editStat = json['editStat'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playListId'] = this.playListId;
    data['playListName'] = this.playListName;
    data['editStat'] = this.editStat;
    return data;
  }
}
