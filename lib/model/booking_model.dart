import 'package:flutter/widgets.dart';

class BookingStateMenu {
  final String title;
  final Widget widget;

  BookingStateMenu.fromMap(Map<String, dynamic> map)
    : title = map['title'],
      widget = map['widget'];
}