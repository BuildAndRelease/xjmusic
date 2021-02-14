import 'package:xj_music/broadcast/base_protocol.dart';

//4.20.13获取指定的专辑收藏夹中专辑列表
class GetFavoriteSetResponseModel extends BaseProtocol {
  String resultCode;
  List list;

  GetFavoriteSetResponseModel(Map json) : super(json) {
    resultCode = arg['resultCode'].toString();
    list = arg['list'];
  }

  get listCount => list?.length ?? 0;

  BasicAlbumSet listAtIndex(int index) {
    BasicAlbumSet basicAlbumSet;
    switch (list[index]["albumSetTypeName"]) {
      case "cloudAlbumSet":
        basicAlbumSet = CloudAlbumSet.fromJson(list[index]);
        break;
      case "cloudSingerSet":
        basicAlbumSet = CloudSingerSet.fromJson(list[index]);
        break;
      case "cloudCategorySet":
        basicAlbumSet = CloudCategorySet.fromJson(list[index]);
        break;
      case "cloudDissSet":
        basicAlbumSet = CloudDissSet.fromJson(list[index]);
        break;
      case "cloudNetRadioSet":
        basicAlbumSet = CloudNetRadioSet.fromJson(list[index]);
        break;
      case "localMusicDirSet":
        basicAlbumSet = LocalMusicDirSet.fromJson(list[index]);
        break;
      case "storyTellingAlbumSet":
        basicAlbumSet = StoryTellingAlbumSet.fromJson(list[index]);
        break;
      case "storyTellingAnchorSet":
        basicAlbumSet = StoryTellingAnchorSet.fromJson(list[index]);
        break;
      default:
        basicAlbumSet = null;
    }
    return basicAlbumSet;
  }
}

abstract class BasicAlbumSet {
  String albumSetTypeName;
}

//云音乐-专辑类
class CloudAlbumSet extends BasicAlbumSet {
  String albumMID;
  String area;
  String genre;
  String id;
  String index;
  String language;
  String name;
  String picUrl;
  String pubTime;
  String singerId;
  String singerMid;
  String singerName;
  String singerType;
  String songNum;

  CloudAlbumSet(
      {albumSetTypeName,
      this.albumMID,
      this.area,
      this.genre,
      this.id,
      this.index,
      this.language,
      this.name,
      this.picUrl,
      this.pubTime,
      this.singerId,
      this.singerMid,
      this.singerName,
      this.singerType,
      this.songNum});

  CloudAlbumSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    albumMID = json['albumMID'].toString();
    area = json['area'].toString();
    genre = json['genre'].toString();
    id = json['id'].toString();
    index = json['index'].toString();
    language = json['language'].toString();
    name = json['name'].toString();
    picUrl = json['pic_url'].toString();
    pubTime = json['pub_time'].toString();
    singerId = json['singer_id'].toString();
    singerMid = json['singer_mid'].toString();
    singerName = json['singer_name'].toString();
    singerType = json['singer_type'].toString();
    songNum = json['song_num'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['albumMID'] = this.albumMID;
    data['area'] = this.area;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['index'] = this.index;
    data['language'] = this.language;
    data['name'] = this.name;
    data['pic_url'] = this.picUrl;
    data['pub_time'] = this.pubTime;
    data['singer_id'] = this.singerId;
    data['singer_mid'] = this.singerMid;
    data['singer_name'] = this.singerName;
    data['singer_type'] = this.singerType;
    data['song_num'] = this.songNum;
    return data;
  }
}

//云音乐-歌手类
class CloudSingerSet extends BasicAlbumSet {
  String farea;
  String findex;
  String fotherName;
  String fsingerId;
  String fsingerMid;
  String fsingerName;
  String fsort;
  String picUrl;
  String type;

  CloudSingerSet(
      {albumSetTypeName,
      this.farea,
      this.findex,
      this.fotherName,
      this.fsingerId,
      this.fsingerMid,
      this.fsingerName,
      this.fsort,
      this.picUrl,
      this.type});

  CloudSingerSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    farea = json['Farea'].toString();
    findex = json['Findex'].toString();
    fotherName = json['Fother_name'].toString();
    fsingerId = json['Fsinger_id'].toString();
    fsingerMid = json['Fsinger_mid'].toString();
    fsingerName = json['Fsinger_name'].toString();
    fsort = json['Fsort'].toString();
    picUrl = json['pic_url'].toString();
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['Farea'] = this.farea;
    data['Findex'] = this.findex;
    data['Fother_name'] = this.fotherName;
    data['Fsinger_id'] = this.fsingerId;
    data['Fsinger_mid'] = this.fsingerMid;
    data['Fsinger_name'] = this.fsingerName;
    data['Fsort'] = this.fsort;
    data['pic_url'] = this.picUrl;
    data['type'] = this.type;

    return data;
  }
}

//云音乐-分类类
class CloudCategorySet extends BasicAlbumSet {
  String pic;
  String tagAlbum;
  String tagAlbumType;
  String tagDiss;
  String tagDissType;
  String tagTrack;
  String tagTrackType;
  String tagId;
  String tagIntro;
  String title;

  CloudCategorySet(
      {albumSetTypeName,
      this.pic,
      this.tagAlbum,
      this.tagAlbumType,
      this.tagDiss,
      this.tagDissType,
      this.tagTrack,
      this.tagTrackType,
      this.tagId,
      this.tagIntro,
      this.title});

  CloudCategorySet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    pic = json['pic'].toString();
    tagAlbum = json['tagAlbum'].toString();
    tagAlbumType = json['tagAlbumType'].toString();
    tagDiss = json['tagDiss'].toString();
    tagDissType = json['tagDissType'].toString();
    tagTrack = json['tagTrack'].toString();
    tagTrackType = json['tagTrackType'].toString();
    tagId = json['tag_id'].toString();
    tagIntro = json['tag_intro'].toString();
    title = json['title'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['pic'] = this.pic;
    data['tagAlbum'] = this.tagAlbum;
    data['tagAlbumType'] = this.tagAlbumType;
    data['tagDiss'] = this.tagDiss;
    data['tagDissType'] = this.tagDissType;
    data['tagTrack'] = this.tagTrack;
    data['tagTrackType'] = this.tagTrackType;
    data['tag_id'] = this.tagId;
    data['tag_intro'] = this.tagIntro;
    data['title'] = this.title;
    return data;
  }
}

//云音乐-歌单类
class CloudDissSet extends BasicAlbumSet {
  String createTime;
  String createrName;
  String dissId;
  String dissName;
  String imgUrl;
  String introduction;
  String listenNum;
  String score;

  CloudDissSet(
      {albumSetTypeName,
      this.createTime,
      this.createrName,
      this.dissId,
      this.dissName,
      this.imgUrl,
      this.introduction,
      this.listenNum,
      this.score});

  CloudDissSet.fromJson(Map json) {
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
    data['albumSetTypeName'] = albumSetTypeName;
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

//云音乐-电台类
class CloudNetRadioSet extends BasicAlbumSet {
  String listenNum;
  String radioId;
  String radioImg;
  String radioName;

  CloudNetRadioSet(
      {albumSetTypeName,
      this.listenNum,
      this.radioId,
      this.radioImg,
      this.radioName});

  CloudNetRadioSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    listenNum = json['listenNum'].toString();
    radioId = json['radioId'].toString();
    radioImg = json['radioImg'].toString();
    radioName = json['radioName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['listenNum'] = this.listenNum;
    data['radioId'] = this.radioId;
    data['radioImg'] = this.radioImg;
    data['radioName'] = this.radioName;
    return data;
  }
}

//本地音乐-歌曲目录类
class LocalMusicDirSet extends BasicAlbumSet {
  String directoryMid;
  String directoryName;

  LocalMusicDirSet({albumSetTypeName, this.directoryMid, this.directoryName});

  LocalMusicDirSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    directoryMid = json['directoryMid'].toString();
    directoryName = json['directoryName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['directoryMid'] = this.directoryMid;
    data['directoryName'] = this.directoryName;
    return data;
  }
}

//语言节目-专辑类
class StoryTellingAlbumSet extends BasicAlbumSet {
  String announcer;
  String description;
  String id;
  String mediaName;
  String mediaTypeName;
  String pic;
  String popNum;
  String score;
  String anchorId;
  String anchorName;
  String tracksCounts;
  String updateTime;

  StoryTellingAlbumSet(
      {albumSetTypeName,
      this.announcer,
      this.description,
      this.id,
      this.mediaName,
      this.mediaTypeName,
      this.pic,
      this.popNum,
      this.score,
      this.anchorId,
      this.anchorName,
      this.tracksCounts,
      this.updateTime});

  StoryTellingAlbumSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    announcer = json['announcer'].toString();
    description = json['description'].toString();
    id = json['id'].toString();
    mediaName = json['mediaName'].toString();
    mediaTypeName = json['mediaTypeName'].toString();
    pic = json['pic'].toString();
    popNum = json['popNum'].toString();
    score = json['score'].toString();
    anchorId = json['anchorId'].toString();
    anchorName = json['anchorName'].toString();
    tracksCounts = json['tracksCounts'].toString();
    updateTime = json['updateTime'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['announcer'] = this.announcer;
    data['description'] = this.description;
    data['id'] = this.id;
    data['mediaName'] = this.mediaName;
    data['mediaTypeName'] = this.mediaTypeName;
    data['pic'] = this.pic;
    data['popNum'] = this.popNum;
    data['score'] = this.score;
    data['anchorId'] = this.anchorId;
    data['anchorName'] = this.anchorName;
    data['tracksCounts'] = this.tracksCounts;
    data['updateTime'] = this.updateTime;
    return data;
  }
}

//语言节目-主播类
class StoryTellingAnchorSet extends BasicAlbumSet {
  String followersCounts;
  String isVerified;
  String nickname;
  String personDescribe;
  String pic;
  String tracksCounts;
  String uid;
  String verifyTitle;

  StoryTellingAnchorSet(
      {albumSetTypeName,
      this.followersCounts,
      this.isVerified,
      this.nickname,
      this.personDescribe,
      this.pic,
      this.tracksCounts,
      this.uid,
      this.verifyTitle});

  StoryTellingAnchorSet.fromJson(Map json) {
    albumSetTypeName = json['albumSetTypeName'].toString();
    followersCounts = json['followersCounts'].toString();
    isVerified = json['isVerified'].toString();
    nickname = json['nickname'].toString();
    personDescribe = json['personDescribe'].toString();
    pic = json['pic'].toString();
    tracksCounts = json['tracksCounts'].toString();
    uid = json['uid'].toString();
    verifyTitle = json['verifyTitle'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumSetTypeName'] = albumSetTypeName;
    data['followersCounts'] = this.followersCounts;
    data['isVerified'] = this.isVerified;
    data['nickname'] = this.nickname;
    data['personDescribe'] = this.personDescribe;
    data['pic'] = this.pic;
    data['tracksCounts'] = this.tracksCounts;
    data['uid'] = this.uid;
    data['verifyTitle'] = this.verifyTitle;
    return data;
  }
}
