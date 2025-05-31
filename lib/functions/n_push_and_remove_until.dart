import 'package:flutter/material.dart';

void nPushAndRemoveUntil(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
    ),
  );
}
