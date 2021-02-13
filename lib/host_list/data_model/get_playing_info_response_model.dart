import 'package:xj_music/broadcast/base_protocol.dart';

//4.4.1获取房间当前信息
class GetPlayingInfoResponseModel extends BaseProtocol {
  Map json;
  String resultCode;
  String roomStat;
  String talkId;
  String partyId;
  BasicMedia media;

  GetPlayingInfoResponseModel(Map json) : super(json) {
    this.json = json;
    resultCode = arg["resultCode"].toString();
    roomStat = arg["roomStat"].toString();
    switch (roomStat) {
      case "inTalk":
        talkId = arg["talkId"].toString();
        break;
      case "inParty":
        partyId = arg["partyId"].toString();
        continue inNormal;
      inNormal:
      case "inNormal":
        if (arg.containsKey("media"))
          switch (arg["media"]["mediaSrc"]) {
            case "cloudMusic":
              media = CloudMusicMedia.fromJson(arg["media"]);
              break;
            case "cloudStoryTelling":
              media = CloudStoryTellingMedia.fromJson(arg["media"]);
              break;
            case "localMusic":
              media = LocalMusicMedia.fromJson(arg["media"]);
              break;
            case "localAux":
              media = LocalAuxMedia.fromJson(arg["media"]);
              break;
            case "cloudNetFm":
              media = CloudNetFmMedia.fromJson(arg["media"]);
              break;
            default:
              media = null;
              break;
          }
        break;
      case "inDlna":
        break;
      case "inAirplay":
        break;
      default:
    }
  }
}

abstract class BasicMedia {
  String mediaSrc;
  Map<String, dynamic> toJson();
}

//云音乐媒体
class CloudMusicMedia extends BasicMedia {
  String songId;
  String songMid;
  String songName;
  String duration;
  List singers;
  String albumId;
  String albumMid;
  String albumName;
  String picUrl;
  String lrcUrl;
  String canPlay;

  CloudMusicMedia(
      {mediaSrc,
      this.songId,
      this.songMid,
      this.songName,
      this.duration,
      this.singers,
      this.albumId,
      this.albumMid,
      this.albumName,
      this.picUrl,
      this.lrcUrl,
      this.canPlay});

  CloudMusicMedia.fromJson(Map json) {
    mediaSrc = json['mediaSrc'].toString();
    songId = json['songId'].toString();
    songMid = json['songMid'].toString();
    songName = json['songName'].toString();
    duration = json['duration'].toString();
    singers = json['singer'];
    albumId = json['albumId'].toString();
    albumMid = json['albumMid'].toString();
    albumName = json['albumName'].toString();
    picUrl = json['picUrl'].toString();
    lrcUrl = json['lrcUrl'].toString();
    canPlay = json['canPlay'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaSrc'] = this.mediaSrc;
    data['songId'] = this.songId;
    data['songMid'] = this.songMid;
    data['songName'] = this.songName;
    data['duration'] = this.duration;
    data['singer'] = this.singers;
    data['albumId'] = this.albumId;
    data['albumMid'] = this.albumMid;
    data['albumName'] = this.albumName;
    data['picUrl'] = this.picUrl;
    data['lrcUrl'] = this.lrcUrl;
    data['canPlay'] = this.canPlay;
    return data;
  }

  get singerCount => singers.length;

  Singer singerAtIndex(int index) {
    return Singer.fromJson(singers[index]);
  }
}

//语言节目媒体
class CloudStoryTellingMedia extends BasicMedia {
  String mid;
  String id;
  String sectionName;
  String duration;
  String parentId;
  String albumId;
  String anchorId;
  String anchorName;
  String updateTime;
  String pic;
  String isUsable;

  CloudStoryTellingMedia(
      {mediaSrc,
      this.mid,
      this.id,
      this.sectionName,
      this.duration,
      this.parentId,
      this.albumId,
      this.anchorId,
      this.anchorName,
      this.updateTime,
      this.pic,
      this.isUsable});

  CloudStoryTellingMedia.fromJson(Map json) {
    mediaSrc = json['mediaSrc'].toString();
    mid = json['mid'].toString();
    id = json['id'].toString();
    sectionName = json['sectionName'].toString();
    duration = json['duration'].toString();
    parentId = json['parentId'].toString();
    albumId = json['albumId'].toString();
    anchorId = json['anchorId'].toString();
    anchorName = json['anchorName'].toString();
    updateTime = json['updateTime'].toString();
    pic = json['pic'].toString();
    isUsable = json['isUsable'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaSrc'] = this.mediaSrc;
    data['mid'] = this.mid;
    data['id'] = this.id;
    data['sectionName'] = this.sectionName;
    data['duration'] = this.duration;
    data['parentId'] = this.parentId;
    data['albumId'] = this.albumId;
    data['anchorId'] = this.anchorId;
    data['anchorName'] = this.anchorName;
    data['updateTime'] = this.updateTime;
    data['pic'] = this.pic;
    data['isUsable'] = this.isUsable;
    return data;
  }
}

//本地音乐
class LocalMusicMedia extends BasicMedia {
  String songId;
  String songMid;
  String songName;
  String duration;
  List singers;
  String albumId;
  String albumMid;
  String albumName;
  String picUrl;
  String lrcUrl;

  LocalMusicMedia(
      {mediaSrc,
      this.songId,
      this.songMid,
      this.songName,
      this.duration,
      this.singers,
      this.albumId,
      this.albumMid,
      this.albumName,
      this.picUrl,
      this.lrcUrl});

  LocalMusicMedia.fromJson(Map json) {
    mediaSrc = json['mediaSrc'].toString();
    songId = json['songId'].toString();
    songMid = json['songMid'].toString();
    songName = json['songName'].toString();
    duration = json['duration'].toString();
    singers = json['singer'];
    albumId = json['albumId'].toString();
    albumMid = json['albumMid'].toString();
    albumName = json['albumName'].toString();
    picUrl = json['picUrl'].toString();
    lrcUrl = json['lrcUrl'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaSrc'] = this.mediaSrc;
    data['songId'] = this.songId;
    data['songMid'] = this.songMid;
    data['songName'] = this.songName;
    data['duration'] = this.duration;
    data['singer'] = this.singers;
    data['albumId'] = this.albumId;
    data['albumMid'] = this.albumMid;
    data['albumName'] = this.albumName;
    data['picUrl'] = this.picUrl;
    data['lrcUrl'] = this.lrcUrl;
    return data;
  }

  get singerCount => singers.length;

  Singer singerAtIndex(int index) {
    return Singer.fromJson(singers[index]);
  }
}

//本地AUX
class LocalAuxMedia extends BasicMedia {
  String auxMid;
  String auxId;

  LocalAuxMedia({mediaSrc, this.auxMid, this.auxId});

  LocalAuxMedia.fromJson(Map json) {
    mediaSrc = json['mediaSrc'].toString();
    auxMid = json['auxMid'].toString();
    auxId = json['auxId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaSrc'] = this.mediaSrc;
    data['auxMid'] = this.auxMid;
    data['auxId'] = this.auxId;
    return data;
  }
}

//网络电台
class CloudNetFmMedia extends BasicMedia {
  String fmUid;
  String id;
  String name;
  String picUrl;
  String playCount;
  String playUrl1;
  String playUrl2;
  String programId;
  String programName;
  String programScheduleId;

  CloudNetFmMedia(
      {mediaSrc,
      this.fmUid,
      this.id,
      this.name,
      this.picUrl,
      this.playCount,
      this.playUrl1,
      this.playUrl2,
      this.programId,
      this.programName,
      this.programScheduleId});

  CloudNetFmMedia.fromJson(Map json) {
    mediaSrc = json['mediaSrc'].toString();
    fmUid = json['fmUid'].toString();
    id = json['id'].toString();
    name = json['name'].toString();
    picUrl = json['picUrl'].toString();
    playCount = json['playCount'].toString();
    playUrl1 = json['playUrl1'].toString();
    playUrl2 = json['playUrl2'].toString();
    programId = json['programId'].toString();
    programName = json['programName'].toString();
    programScheduleId = json['programScheduleId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaSrc'] = this.mediaSrc;
    data['fmUid'] = this.fmUid;
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['playCount'] = this.playCount;
    data['playUrl1'] = this.playUrl1;
    data['playUrl2'] = this.playUrl2;
    data['programId'] = this.programId;
    data['programName'] = this.programName;
    data['programScheduleId'] = this.programScheduleId;
    return data;
  }
}

class Singer {
  String id;
  String mid;
  String name;

  Singer({this.id, this.mid, this.name});

  Singer.fromJson(Map json) {
    id = json['id'].toString();
    mid = json['mid'].toString();
    name = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mid'] = this.mid;
    data['name'] = this.name;
    return data;
  }
}
