import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/sub_category.dart';

class DisplaySubCategories extends StatefulWidget {
  List<Category> items;
  final Function changeSelected;
  final int currentIndex;

  DisplaySubCategories(this.items, this.changeSelected, this.currentIndex);

  @override
  State<DisplaySubCategories> createState() => _DisplaySubCategoriesState();
}

class _DisplaySubCategoriesState extends State<DisplaySubCategories> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        height: 150,
        width: 300,
        child: widget.currentIndex != -1
            ? ListView.builder(itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.items[widget.currentIndex].subCategories?[index]
                            .name as String,
                      ),
                      Checkbox(
                          value: widget.items[widget.currentIndex]
                              .subCategories?[index].selected,
                          onChanged: (value) {
                            setState(() {
                              List<SubCategory>? aux = widget
                                  .items[widget.currentIndex].subCategories;

                              aux?[index].selected = value!;
                              widget.changeSelected(widget
                                  .items[widget.currentIndex]
                                  .subCategories?[index]);
                            });
                          })
                    ],
                  ),
                );
              })
            : Center(
                child: Text(
                'Such emptiness',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
      ),
    );
  }
}
