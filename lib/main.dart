import 'package:covid/bloc/bloc.dart';
import 'package:covid/bloc/events.dart';
import 'package:covid/bloc/states.dart';
import 'package:covid/data/models/Response.dart';
import 'package:covid/presentation/models/Model.dart';
import 'package:covid/presentation/widgets/main_widgets.dart';
import 'package:covid/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

void main() => runApp(Application());

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
            create: (context) => MainBloc(Repository()),
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

//TODO inherited widget

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //TODO dependency injection
    //TODO('Change')
    final bloc = BlocProvider.of<MainBloc>(context);
    bloc.add(Events.getSummaryInfo);

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
                  sliverAppBar(context, state.result.global),
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
        return bloc.add(Events.getSummaryInfo);
      },
    );
  }

  List<Country> sortCountriesByConfirmed(Model result) {
    result.countries
        .sort((a, b) => a.totalConfirmed.compareTo(b.totalConfirmed));
    final sortedList = result.countries.reversed.toList();
    return sortedList;
  }
}
