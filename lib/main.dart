import 'package:covid/bloc/bloc.dart';
import 'package:covid/bloc/events.dart';
import 'package:covid/bloc/states.dart';
import 'package:covid/locator.dart';
import 'package:covid/presentation/utils/utils.dart';
import 'package:covid/presentation/widgets/main_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() {
  setupLocator();
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[200],
          body: BlocProvider(
            create: (context) => locator<MainBloc>(),
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(Events.getSummaryInfo);
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          //TODO Use 2 states
          if (state is Loading) {
            return spinKit(context);
          } else if (state is SuccessResponse) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 24,
              child: CustomScrollView(
                slivers: <Widget>[
                  sliverAppBar(context, state.result.Global),
                  sliverList(context, sortCountriesByConfirmed(state.result))
                ],
              ),
            );
          } else {
            return error(context);
          }
        },
      ),
      onRefresh: () async {
        return didChangeDependencies();
      },
    );
  }
}
