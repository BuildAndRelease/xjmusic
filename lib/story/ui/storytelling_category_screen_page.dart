import 'package:flutter/material.dart';
import 'package:xj_music/host_list/data_model/get_storytelling_category_response_model.dart';

class StorytellingCategoryScreenPage extends StatefulWidget {
  final Category category;
  final SubCategory selectCategory;
  final Function(SubCategory subCategory) onSelectType;

  const StorytellingCategoryScreenPage(
      this.category, this.selectCategory, this.onSelectType);
  @override
  _StorytellingCategoryScreenPageState createState() =>
      _StorytellingCategoryScreenPageState();
}

class _StorytellingCategoryScreenPageState
    extends State<StorytellingCategoryScreenPage> {
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
        final subCategory = widget.category.subCategoryListAtIndex(index);
        return _buildScreeningItem(subCategory);
      },
      itemCount: (widget.category.subCategoryListCount ?? 0),
    );
  }

  Widget _buildScreeningItem(SubCategory subCategory) {
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
                subCategory.categoryName,
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
              child: Text(subCategory.categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center)),
    );
  }
}
