import 'package:covid/bloc/events/mainEvents.dart';
import 'package:covid/bloc/mainBloc.dart';
import 'package:covid/locator.dart';
import 'package:covid/presentation/widgets/main_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/states/mainStates.dart';
import 'models/main_model.dart';

void main() {
  setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[200],
          body: BlocProvider(
            create: (context) => MainBloc(),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  String filter;
  Main_model cachedModel;

  _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 60),
      content: Text(message),
      action: SnackBarAction(
        label: 'Retry',
        onPressed: () => {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(MainEvents.getMainInfo);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => null,
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is Loading) {
            return spinKit(context, 'Loading');
          } else if (state is Completed) {
            cachedModel = state.mainInfo;
            return mainWidget(context, state.mainInfo, controller, filter);
          } else if (state is Error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showSnackBar(context, 'Error');
            });
            if (cachedModel != null) {
              return mainWidget(context, cachedModel, controller, filter);
            } else
              return Container();
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
