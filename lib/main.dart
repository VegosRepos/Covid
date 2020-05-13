import 'package:covid/bloc/bloc.dart';
import 'package:covid/locator.dart';
import 'package:covid/presentation/widgets/main_widgets.dart';
import 'package:flutter/material.dart';

import 'data/remote/models/api_response.dart';
import 'models/main_model.dart';

void main() {
  setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SafeArea(child: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainBloc _bloc;

  @override
  void initState() {
    _bloc = MainBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: RefreshIndicator(
        backgroundColor: Colors.green[200],
        color: Colors.green[200],
        onRefresh: () => _bloc.fetchData(),
        child: StreamBuilder<ApiResponse<Main_model>>(
          stream: _bloc.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return spinKit(context, snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return mainWidget(context, snapshot.data.data);
                  break;
                case Status.ERROR:
                  return errorWidget(context, snapshot.data.message, _bloc);
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
