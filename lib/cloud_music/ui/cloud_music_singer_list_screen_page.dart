import 'package:flutter/material.dart';

Map<String, String> singerAreaInfo = {
  "all_all": "热门",
  "cn_man": "华语男",
  "cn_woman": "华语女",
  "cn_team": "华语组合",
  "k_man": "韩国男",
  "k_woman": "韩国女",
  "k_team": "韩国组合",
  "j_man": "日本男",
  "j_woman": "日本女",
  "j_team": "日本组合",
  "eu_man": "欧美男",
  "eu_woman": "欧美女",
  "eu_team": "欧美组合",
  "c_orchestra": "乐团",
  "c_performer": "演奏家",
  "c_composer": "作曲家",
  "c_cantor": "指挥家",
  "other_other": "其他"
};

Map<String, String> singerIndexInfo = {
  "all": "所有",
  "A": "A",
  "B": "B",
  "C": "C",
  "D": "D",
  "E": "E",
  "F": "F",
  "G": "G",
  "H": "H",
  "I": "I",
  "J": "J",
  "K": "K",
  "L": "L",
  "M": "M",
  "N": "N",
  "O": "O",
  "P": "P",
  "Q": "Q",
  "R": "R",
  "S": "S",
  "T": "T",
  "U": "U",
  "V": "V",
  "W": "W",
  "X": "X",
  "Y": "Y",
  "Z": "Z",
  "9": "#",
};

class CloudMusicSingerListScreenPage extends StatefulWidget {
  final String area;
  final String index;
  final Function(String type, String index) onSelectType;
  const CloudMusicSingerListScreenPage(
      this.index, this.area, this.onSelectType);
  @override
  _CloudMusicSingerListScreenPageState createState() =>
      _CloudMusicSingerListScreenPageState();
}

class _CloudMusicSingerListScreenPageState
    extends State<CloudMusicSingerListScreenPage> {
  String _index = "all";
  String _area = "all_all";

  @override
  void initState() {
    _area = widget.area;
    _index = widget.index;
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
            singerAreaInfo.forEach((key, value) {
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
            singerIndexInfo.forEach((key, value) {
              widgets.add(_buildScreeningItem(key, value, "index"));
            });
            return Wrap(
              spacing: 5,
              runSpacing: 5,
              children: widgets,
            );
            break;
          case 5:
            return Divider(height: 8);
          default:
            return const SizedBox();
        }
      },
      itemCount: 6,
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
