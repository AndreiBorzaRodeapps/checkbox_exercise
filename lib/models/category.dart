import './sub_category.dart';

class Category {
  final String? name;
  final List<SubCategory> ?subCategories;
  bool selected;

  Category({this.name, this.subCategories, this.selected = false});
}
