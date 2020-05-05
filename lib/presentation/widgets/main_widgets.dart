import 'package:covid/data/models/Response.dart';
import 'package:covid/presentation/pages/description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

Widget spinKit(BuildContext context) {
  return Center(
    child: CircleAvatar(
      backgroundImage: AssetImage('images/corona.png'),
      radius: 40,
      backgroundColor: Colors.transparent,
      child:
          SpinKitRing(color: Colors.deepOrange[300], size: 100, lineWidth: 3),
    ),
  );
}

Widget error(BuildContext context) {
  return Center(
      child: Text(
    'Oups! An error occured',
    style: GoogleFonts.andika(fontSize: 15, color: Colors.deepOrange[800]),
  ));
}

Widget cardView(BuildContext context, Country country, int index) {
  return Card(
    color: Colors.deepOrange[300],
    child: ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Description(country: country);
        }));
      },
      title: Text(
        country.country.toString(),
        style: GoogleFonts.aBeeZee(color: Colors.white),
      ),
      leading: Text(index.toString(),
          style: GoogleFonts.aBeeZee(color: Colors.white70)),
    ),
  );
}

Widget sliverAppBar(BuildContext context, Global global) {
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
              Text(global.totalConfirmed.toString(),
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25, color: Colors.yellow[300]))
            ],
          ),
          Column(
            children: <Widget>[
              Text('Deaths',
                  style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              Text(global.totalDeaths.toString(),
                  style:
                      GoogleFonts.aBeeZee(fontSize: 25, color: Colors.red[400]))
            ],
          ),
          Column(
            children: <Widget>[
              Text('Recovered',
                  style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              Text(global.totalRecovered.toString(),
                  style: GoogleFonts.aBeeZee(
                      fontSize: 25, color: Colors.green[800]))
            ],
          )
        ],
      ),
    ),
  );
}

Widget sliverList(BuildContext context, List<Country> countries) {
  return SliverList(
    delegate: SliverChildBuilderDelegate((context, index) {
      return cardView(context, countries[index], index + 1);
    }, childCount: countries.length),
  );
}
