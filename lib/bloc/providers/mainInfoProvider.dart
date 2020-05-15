import 'package:covid/models/index.dart';
import 'package:flutter/cupertino.dart';

class MainInfoProvider extends InheritedWidget {
  final Main_model mainInfo;
  TextEditingController controller;
  final Widget child;
  final String filter;

  MainInfoProvider({this.mainInfo, this.child, this.filter, this.controller})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainInfoProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MainInfoProvider>();
}
