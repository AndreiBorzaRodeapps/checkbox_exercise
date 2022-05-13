import 'package:checkbox_exercise/models/sub_category.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

class DisplayCategories extends StatefulWidget {
  List<Category> categories;
  final Function changeSelected;
  final Function indexUpdater;
  final Function subCategoriesRefresher;

  DisplayCategories(this.categories, this.changeSelected, this.indexUpdater,
      this.subCategoriesRefresher);

  @override
  State<DisplayCategories> createState() => _DisplayCategoriesState();
}

class _DisplayCategoriesState extends State<DisplayCategories> {
  String selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Categories :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 160,
                width: 300,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: Checkbox(
                            value: widget.categories[index].selected,
                            onChanged: (value) {
                              if (value == true) {
                                bool ok = true;
                                for (var i = 0;
                                    i < widget.categories.length;
                                    i++) {
                                  if (i == index) continue;

                                  if (widget.categories[i].selected == true) {
                                    ok = false;
                                  }
                                }
                                setState(() {
                                  if (ok) {
                                    widget.categories[index].selected = value!;
                                    widget.changeSelected(
                                        widget.categories[index]);

                                    widget.indexUpdater(index);

                                    selectedCategory = widget
                                        .categories[index].name
                                        .toString();
                                  }
                                });
                              } else {
                                setState(() {
                                  widget.categories[index].selected = value!;
                                  widget
                                      .changeSelected(widget.categories[index]);

                                  selectedCategory = '';
                                  widget.indexUpdater(-1);
                                  widget.subCategoriesRefresher();
                                });
                              }
                            },
                          ),
                        ),
                        Text(widget.categories[index].name.toString()),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    );
                  },
                  itemCount: widget.categories.length,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Selected: $selectedCategory'),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
