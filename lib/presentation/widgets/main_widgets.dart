import 'package:covid/models/country_model.dart';
import 'package:covid/models/global_model.dart';
import 'package:covid/models/index.dart';
import 'package:covid/presentation/animations/page_animation.dart';
import 'package:covid/presentation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SpinKit extends StatelessWidget {
  final String message;

  SpinKit(this.message);

  @override
  Widget build(BuildContext context) {
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
}

class CardView extends StatelessWidget {
  final Country_model country;
  final int index;

  CardView(this.country, this.index);

  @override
  Widget build(BuildContext context) {
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
}

class Sliver extends StatelessWidget {
  final Global_model global;

  Sliver(this.global);

  @override
  Widget build(BuildContext context) {
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
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25, color: Colors.red[400]))
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
}

class Slivers extends StatelessWidget {
  final List<Country_model> countries;
  final String filter;

  Slivers(this.countries, this.filter);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return filter == null || filter == ""
            ? CardView(countries[index], index + 1)
            : countries[index]
                    .Country
                    .toLowerCase()
                    .contains(filter.toLowerCase())
                ? CardView(countries[index], index + 1)
                : Container();
      }, childCount: countries.length),
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController controller;

  SearchField(this.controller);

  @override
  Widget build(BuildContext context) {
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
}

class MainWidget extends StatelessWidget {
  final Main_model mainInfo;
  final TextEditingController controller;
  final String filter;

  MainWidget(this.mainInfo, this.controller, this.filter);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 24,
      child: CustomScrollView(
        slivers: <Widget>[
          Sliver(mainInfo.Global),
          SearchField(controller),
          Slivers(sortCountriesByConfirmed(mainInfo), filter)
        ],
      ),
    );
  }
}
