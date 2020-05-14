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
  TextEditingController controller = new TextEditingController();
  String filter;
  Main_model cachedModel;

  _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 60),
      content: Text(message),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () => _bloc.fetchData(),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    _bloc = MainBloc();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: RefreshIndicator(
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
                  cachedModel = snapshot.data.data;
                  return mainWidget(
                      context, snapshot.data.data, controller, filter);
                  break;
                case Status.ERROR:
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showSnackBar(context, snapshot.data.message);
                  });
                  if (cachedModel != null) {
                    return mainWidget(context, cachedModel, controller, filter);
                  } else
                    return Container();
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
    controller.dispose();
    super.dispose();
  }
}
