import 'package:covid/bloc/events/mainEvents.dart';
import 'package:covid/bloc/mainBloc.dart';
import 'package:covid/locator.dart';
import 'package:covid/presentation/snackbars/errorSnack.dart';
import 'package:covid/presentation/widgets/main_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/providers/mainInfoProvider.dart';
import 'bloc/states/mainStates.dart';

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
  TextEditingController _controller = new TextEditingController();
  String _filter;
  MainBloc _bloc;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _filter = _controller.text;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc = BlocProvider.of<MainBloc>(context);
    _bloc.add(MainEvents.getMainInfo);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MainInfoProvider(
      mainInfo: _bloc.mainInfo,
      filter: _filter,
      controller: _controller,
      child: RefreshIndicator(
        onRefresh: () async => _bloc.add(MainEvents.getMainInfo),
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is Loading) {
              return SpinKit('Loading');
            } else if (state is Completed) {
              return MainWidget(state.mainInfo, _controller);
            } else if (state is Error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorSnackBar(context, _bloc, 'An error occurred');
              });
              if (_bloc.mainInfo != null) {
                return MainWidget(_bloc.mainInfo, _controller);
              } else
                return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _controller.dispose();
    super.dispose();
  }
}
