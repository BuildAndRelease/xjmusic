import 'package:flutter/material.dart';
import 'package:xj_music/host_list/data_model/get_diss_category_response_model.dart';

class CloudMusicDissListScreenPage extends StatefulWidget {
  final GetDissCategoryResponseModel dissCategoryResponseModel;
  final String categoryId;
  final Function(String categoryId) onSelectCategory;
  const CloudMusicDissListScreenPage(
      this.dissCategoryResponseModel, this.categoryId, this.onSelectCategory);
  @override
  _CloudMusicDissListScreenPageState createState() =>
      _CloudMusicDissListScreenPageState();
}

class _CloudMusicDissListScreenPageState
    extends State<CloudMusicDissListScreenPage> {
  String _categoryId = "0";

  @override
  void initState() {
    _categoryId = widget.categoryId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final categoryItem =
            widget.dissCategoryResponseModel.categoriesAtIndex(index);
        List<Widget> items = [];
        for (var i = 0; i < categoryItem.itemsCount; i++) {
          final item = categoryItem.itemsAtIndex(i);
          items.add(_buildScreeningItem(item.categoryId, item.categoryName));
        }
        return ListTile(
          leading: Text(categoryItem.categoryGroupName),
          title: Wrap(
            spacing: 0,
            runSpacing: 0,
            children: items,
          ),
        );
      },
      itemCount: widget.dissCategoryResponseModel?.categoriesCount ?? 0,
    );
  }

  Widget _buildScreeningItem(String categoryId, String categoryName) {
    bool select = categoryId == _categoryId;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        _categoryId = categoryId;
        widget.onSelectCategory?.call(categoryId);
        setState(() {});
      },
      child: select
          ? Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              color: theme.primaryColor,
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
              ),
            )
          : Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              child: Text(categoryName, textAlign: TextAlign.center)),
    );
  }
}
