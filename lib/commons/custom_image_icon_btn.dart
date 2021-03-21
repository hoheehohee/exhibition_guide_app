import 'package:flutter/material.dart';

class CustomImageIconBtn extends StatelessWidget {
  CustomImageIconBtn({
    Key key,
    this.px,
    this.iconPath,
    this.onAction,
    this.disabled = false
  }) : super(key: key);

  final double px;
  final bool disabled;
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
      onPressed: disabled ? null : () {
        if (onAction != null) {
          onAction();
        }
      },
    );
  }
}
