import 'package:covid/bloc/bloc.dart';
import 'package:covid/models/country_model.dart';
import 'package:covid/models/global_model.dart';
import 'package:covid/models/index.dart';
import 'package:covid/presentation/animations/page_animation.dart';
import 'package:covid/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Widget spinKit(BuildContext context, String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('images/corona.png'),
          radius: 40,
          backgroundColor: Colors.transparent,
          child: SpinKitRing(
              color: Colors.deepOrange[300], size: 100, lineWidth: 3),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              color: Colors.green[800],
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget error(BuildContext context) {
  return Container();
}

Widget cardView(BuildContext context, Country_model country, int index) {
  return Card(
    color: Colors.deepOrange[300],
    child: ListTile(
      onTap: () {
        Navigator.of(context).push(routeToDescription(country));
      },
      title: Text(
        country.Country.toString(),
        style: GoogleFonts.aBeeZee(color: Colors.white),
      ),
      leading: Text(index.toString(),
          style: GoogleFonts.aBeeZee(color: Colors.white70)),
    ),
  );
}

Widget sliverAppBar(BuildContext context, Global_model global) {
  return SliverAppBar(
    expandedHeight: 300,
    backgroundColor: Colors.green[200],
    flexibleSpace: FlexibleSpaceBar(
      background: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text('Confirmed',
                  style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              Text(global.TotalConfirmed.toString(),
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25, color: Colors.yellow[300]))
            ],
          ),
          Column(
            children: <Widget>[
              Text('Deaths',
                  style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              Text(global.TotalDeaths.toString(),
                  style:
                      GoogleFonts.aBeeZee(fontSize: 25, color: Colors.red[400]))
            ],
          ),
          Column(
            children: <Widget>[
              Text('Recovered',
                  style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              Text(global.TotalRecovered.toString(),
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25, color: Colors.green[800]))
            ],
          )
        ],
      ),
    ),
  );
}

Widget sliverList(
    BuildContext context, List<Country_model> countries, String filter) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return filter == null || filter == ""
          ? cardView(context, countries[index], index + 1)
          : countries[index]
                  .Country
                  .toLowerCase()
                  .contains(filter.toLowerCase())
              ? cardView(context, countries[index], index + 1)
              : Container();
    }, childCount: countries.length),
  );
}

Widget searchField(BuildContext context, TextEditingController controller) {
  return SliverAppBar(
    backgroundColor: Colors.transparent,
    expandedHeight: 100,
    title: TextField(
      decoration: InputDecoration(
          labelText: "Search something", fillColor: Colors.transparent),
      controller: controller,
    ),
  );
}

Widget mainWidget(BuildContext context, Main_model model,
    TextEditingController controller, String filter) {
  return SizedBox(
    height: MediaQuery.of(context).size.height - 24,
    child: CustomScrollView(
      slivers: <Widget>[
        sliverAppBar(context, model.Global),
        searchField(context, controller),
        sliverList(context, sortCountriesByConfirmed(model), filter)
      ],
    ),
  );
}

Widget errorWidget(BuildContext context, String message, MainBloc bloc) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(
              fontSize: 20,
              color: Colors.red[600],
            ),
          ),
        ),
        FlatButton(
          color: Colors.redAccent,
          child: Text('Retry',
              style:
                  GoogleFonts.aBeeZee(fontSize: 25, color: Colors.green[200])),
          onPressed: () {
            bloc.fetchData();
          },
        )
      ],
    ),
  );
}
