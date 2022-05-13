import 'dart:io';

import '../widgets/display_SubCategories.dart';
import '../widgets/display_Categories.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/sub_category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Exercise',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.redAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  List<Category> _selectedCategories = [];
  List<SubCategory> _selectedSubcategories = [];
  String _displayedMessage = '';
  int _index = -1;

  final _appBar = AppBar(
    title: Center(
      child: Text(
        'Exercise',
      ),
    ),
  );

  List<Category> _displayValues = [
    Category(
      name: 'Fruits',
      subCategories: [
        SubCategory(name: 'Apple'),
        SubCategory(name: 'Banana'),
        SubCategory(name: 'Kiwi'),
      ],
    ),
    Category(
      name: 'Vegetables',
      subCategories: [
        SubCategory(name: 'Cucumber'),
        SubCategory(name: 'Lettuce'),
        SubCategory(name: 'Onion'),
      ],
    ),
    Category(
      name: 'Milk',
      subCategories: [
        SubCategory(name: 'Simple'),
        SubCategory(name: 'Almond'),
        SubCategory(name: 'Chocolate'),
      ],
    ),
  ];

  void _updateSelectedCategories(Category category) {
    setState(() {
      if (category.selected) {
        _selectedCategories.add(category);
      } else {
        _selectedCategories.remove(category);
      }
    });
  }

  void _updateSelectedSubCategories(SubCategory subCategory) {
    setState(() {
      if (subCategory.selected)
        _selectedSubcategories.add(subCategory);
      else
        _selectedSubcategories.remove(subCategory);
    });
  }

  void _refreshSubCategories(Category category) {
    setState(() {
      List<SubCategory> aux = category.subCategories!;

      for (var i = 0; i < aux.length; i++) {
        category.subCategories?[i].selected = false;
      }
    });
  }

  void updateIndex(int nr) {
    setState(() {
      _index = nr;
    });
  }

  void _updateDisplay() {
    _displayedMessage = _selectedCategories.map((el) => el.name).join(' ') +
        ': ' +
        _selectedSubcategories.map((el) => el.name).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            DisplayCategories(_displayValues, _updateSelectedCategories,
                updateIndex, _refreshSubCategories),
            SizedBox(height: 20),
            DisplaySubCategories(
              _displayValues,
              _updateSelectedSubCategories,
              _index,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text(
                'Send info',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  _updateDisplay();
                });
              },
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(_displayedMessage),
          ],
        ),
      ),
    );
  }
}
