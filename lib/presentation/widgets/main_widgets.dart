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

Widget cardView(BuildContext context, Country_model country, int index) {
  return Card(
    color: Colors.deepOrange[300],
    child: ListTile(
      onTap: () {
        FocusScope.of(context).unfocus();
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
    floating: false,
    expandedHeight: 300,
    backgroundColor: Colors.green[200],
    flexibleSpace: FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
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
                      fontSize: 25, color: Colors.yellow[200]))
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
    pinned: true,
    floating: true,
    backgroundColor: Colors.grey[200],
    title: TextField(
      style: GoogleFonts.aBeeZee(color: Colors.green[800], fontSize: 16),
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: 'Country',
        hintStyle: GoogleFonts.aBeeZee(color: Colors.grey[400]),
        suffixIcon: FlatButton(
            shape: CircleBorder(),
            child: Icon(
              Icons.clear,
              color: Colors.red[300],
            ),
            onPressed: () {
              controller.clear();
            }),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.green,
        ),
        prefixText: ' ',
      ),
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
