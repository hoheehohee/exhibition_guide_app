import 'package:flutter/material.dart';

class CustomImageIconBtn extends StatelessWidget {
  CustomImageIconBtn({
    Key key,
    this.px,
    this.iconPath,
    this.onAction
  }) : super(key: key);

  final double px;
  final String iconPath;
  final onAction;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        width: px,
        child: Image.asset(
          iconPath,
          fit: BoxFit.fill,
        ),
      ),
      onPressed: () {
        if (onAction != null) {
          onAction();
        }
      },
    );
  }
}
