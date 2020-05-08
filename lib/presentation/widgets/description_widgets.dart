import 'package:covid/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget info(String description, String info) {
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

Widget countryDescription(BuildContext context, Country_model country) {
  return Column(
    children: <Widget>[
      info('New confirmed:', country.NewConfirmed.toString()),
      info('Total confirmed:', country.TotalConfirmed.toString()),
      info('New deaths:', country.NewDeaths.toString()),
      info('Total deaths:', country.TotalDeaths.toString()),
      info('New recovered:', country.NewRecovered.toString()),
      info('Total recovered:', country.TotalRecovered.toString()),
    ],
  );
}
