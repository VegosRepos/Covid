import 'package:covid/bloc/events/mainEvents.dart';
import 'package:covid/bloc/mainBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showErrorSnackBar(BuildContext context, MainBloc bloc, String message) {
  final snackBar = SnackBar(
    duration: Duration(seconds: 60),
    content: Text(message),
    action: SnackBarAction(
      label: 'Retry',
      onPressed: () async => bloc.add(MainEvents.getMainInfo),
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
