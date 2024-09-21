import 'package:flutter/material.dart';

class ResponsiveMainPage extends StatelessWidget {
  final Widget mobile;
  final Widget web;
  const ResponsiveMainPage(
      {super.key, required this.mobile, required this.web});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        }
        return web;
      },
    );
  }
}
