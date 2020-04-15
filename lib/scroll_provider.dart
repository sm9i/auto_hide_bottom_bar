import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollProvider extends ChangeNotifier {
  ScrollDirection _scrollDirection;

  set scrollDirection(ScrollDirection value) {
    _scrollDirection = value;
    notifyListeners();
  }

  ScrollDirection get scrollDirection => _scrollDirection;
}
