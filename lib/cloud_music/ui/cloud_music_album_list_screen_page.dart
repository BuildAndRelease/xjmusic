import 'package:flutter/material.dart';

Map<String, String> sortType = {
  "1": "发布时间",
  "2": "收听量",
  "3": "评分",
  "4": "下载品质"
};
Map<String, String> timeType = {
  "0": "全部",
  "1": "最近七天",
  "2": "最近一月",
  "3": "最近一季"
};
Map<String, String> typeType = {
  "0": "全部",
  "1": "流行",
  "2": "摇滚",
  "3": "R&B",
  "4": "乡村",
  "5": "新世纪",
  "6": "嘻哈",
  "7": "世界",
  "8": "布鲁斯",
  "9": "爵士",
  "10": "民谣",
  "11": "拉丁",
  "12": "雷鬼",
  "13": "金属",
  "14": "儿童",
  "15": "影视",
  "16": "游戏",
  "17": "动漫",
  "18": "舞曲",
  "19": "网络",
  "20": "古典",
  "21": "轻音乐",
  "22": "民歌",
  "23": "经典",
  "24": "对唱",
  "25": "胎教音乐"
};
Map<String, String> areaType = {
  "0": "全部",
  "1": "国语",
  "2": "粤语",
  "3": "台语",
  "4": "英文",
  "5": "日语",
  "6": "韩语",
  "7": "法语",
  "8": "西班牙语",
  "9": "德语",
  "10": "俄语",
  "11": "其他",
};
Map<String, String> indexType = {
  "0": "全部",
  "1": "A",
  "2": "B",
  "3": "C",
  "4": "D",
  "5": "E",
  "6": "F",
  "7": "G",
  "8": "H",
  "9": "I",
  "10": "J",
  "11": "K",
  "12": "L",
  "13": "M",
  "14": "N",
  "15": "O",
  "16": "P",
  "17": "Q",
  "18": "R",
  "19": "S",
  "20": "T",
  "21": "U",
  "22": "V",
  "23": "W",
  "24": "X",
  "25": "Y",
  "26": "Z",
  "27": "#",
};

class CloudMusicAlbumListScreenPage extends StatefulWidget {
  final String sort;
  final String index;
  final String area;
  final String time;
  final String type;
  final Function(String type, String index) onSelectType;
  const CloudMusicAlbumListScreenPage(this.sort, this.index, this.area,
      this.time, this.type, this.onSelectType);

  @override
  _CloudMusicAlbumListScreenPageState createState() =>
      _CloudMusicAlbumListScreenPageState();
}

class _CloudMusicAlbumListScreenPageState
    extends State<CloudMusicAlbumListScreenPage> {
  String _sort = "1";
  String _index = "0";
  String _area = "0";
  String _time = "0";
  String _type = "0";

  @override
  void initState() {
    _area = widget.area;
    _index = widget.index;
    _sort = widget.sort;
    _time = widget.time;
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text("地区"),
            );
            break;
          case 1:
            final List<Widget> widgets = [];
            areaType.forEach((key, value) {
              widgets.add(_buildScreeningItem(key, value, "area"));
            });
            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widgets,
            );
            break;
          case 2:
            return Divider(height: 8);
          case 3:
            return Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text("类型"),
            );
            break;
          case 4:
            final List<Widget> widgets = [];
            typeType.forEach((key, value) {
              widgets.add(_buildScreeningItem(key, value, "type"));
            });
            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widgets,
            );
            break;
          case 5:
            return Divider(height: 8);
          case 6:
            return Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text("时间"),
            );
            break;
          case 7:
            final List<Widget> widgets = [];
            timeType.forEach((key, value) {
              widgets.add(_buildScreeningItem(key, value, "time"));
            });
            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widgets,
            );
            break;
          case 8:
            return Divider(height: 8);
          case 9:
            return Container(
              height: 30,
              alignment: Alignment.centerLeft,
              child: Text("索引"),
            );
            break;
          case 10:
            final List<Widget> widgets = [];
            indexType.forEach((key, value) {
              widgets.add(_buildScreeningItem(key, value, "index"));
            });
            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widgets,
            );
            break;
          case 11:
            return Divider(height: 8);
          default:
            return const SizedBox();
        }
      },
      itemCount: 12,
    );
  }

  Widget _buildScreeningItem(
      String typeIndex, String typeName, String currentType) {
    bool select = false;
    switch (currentType) {
      case "area":
        select = _area == typeIndex;
        break;
      case "index":
        select = _index == typeIndex;
        break;
      case "sort":
        select = _sort == typeIndex;
        break;
      case "time":
        select = _time == typeIndex;
        break;
      case "type":
        select = _type == typeIndex;
        break;
      default:
        break;
    }
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        switch (currentType) {
          case "area":
            _area = typeIndex;
            widget.onSelectType?.call("area", _area);
            break;
          case "index":
            _index = typeIndex;
            widget.onSelectType?.call("index", _index);
            break;
          case "sort":
            _sort = typeIndex;
            widget.onSelectType?.call("sort", _sort);
            break;
          case "time":
            _time = typeIndex;
            widget.onSelectType?.call("time", _time);
            break;
          case "type":
            _type = typeIndex;
            widget.onSelectType?.call("type", _type);
            break;
          default:
            break;
        }
        setState(() {});
      },
      child: select
          ? Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              color: theme.primaryColor,
              child: Text(
                typeName,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
              ),
            )
          : Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              child: Text(typeName, textAlign: TextAlign.center)),
    );
  }
}
