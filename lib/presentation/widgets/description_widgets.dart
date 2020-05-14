import 'package:covid/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  final String description;
  final String info;

  const Info(this.description, this.info);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 70,
        color: Colors.grey[100],
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(description, style: GoogleFonts.aBeeZee()),
              Text(info, style: GoogleFonts.aBeeZee(color: Colors.red[700]))
            ]),
      ),
      color: Colors.grey[100],
    );
  }
}

class CountryDescription extends StatelessWidget {
  final Country_model country;

  const CountryDescription(this.country);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Info('New confirmed:', country.NewConfirmed.toString()),
        Info('Total confirmed:', country.TotalConfirmed.toString()),
        Info('New deaths:', country.NewDeaths.toString()),
        Info('Total deaths:', country.TotalDeaths.toString()),
        Info('New recovered:', country.NewRecovered.toString()),
        Info('Total recovered:', country.TotalRecovered.toString()),
      ],
    );
  }
}
