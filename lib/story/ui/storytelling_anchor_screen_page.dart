import 'package:flutter/material.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_anchor_category_list_response_model.dart';

class StorytellingAnchorScreenPage extends StatefulWidget {
  final GetStorytellingAnchorCategoryResponseModel category;
  final StorytellingAnchorCategory selectCategory;
  final Function(StorytellingAnchorCategory subCategory) onSelectType;

  const StorytellingAnchorScreenPage(
      this.category, this.selectCategory, this.onSelectType);
  @override
  _StorytellingAnchorScreenPageState createState() =>
      _StorytellingAnchorScreenPageState();
}

class _StorytellingAnchorScreenPageState
    extends State<StorytellingAnchorScreenPage> {
  String _categoryId;

  @override
  void initState() {
    _categoryId = widget.selectCategory.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 4 / 1.5),
      itemBuilder: (context, index) {
        final subCategory = widget.category.categoryListAtIndex(index);
        return _buildScreeningItem(subCategory);
      },
      itemCount: (widget.category.categoryListCount ?? 0),
    );
  }

  Widget _buildScreeningItem(StorytellingAnchorCategory subCategory) {
    bool select = subCategory.id == _categoryId;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        _categoryId = subCategory.id;
        widget.onSelectType?.call(subCategory);
        setState(() {});
      },
      child: select
          ? Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              color: theme.primaryColor,
              child: Text(
                subCategory.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyText2.copyWith(color: Colors.white),
              ),
            )
          : Container(
              width: 70,
              height: 30,
              alignment: Alignment.center,
              child: Text(subCategory.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center)),
    );
  }
}
