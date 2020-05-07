import 'package:covid/data/models/Response.dart';
import 'package:covid/presentation/pages/description.dart';
import 'package:flutter/widgets.dart';

Route routeToDescription(Country country) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        Description(country: country),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOutExpo;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
