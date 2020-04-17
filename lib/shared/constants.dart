import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Color(0xFF947C6A),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF947C6A), width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    )
  );


//the default game locations
const List<String> defaultLocations = ["Airplane", "Amusement Park", "Aquarium", "Art Museum", "Bank", "Beach", "Blimp", "Bus", "Cemetery", "Cinema", "Casino", "Cathedral",
  "Circus", "Concert", "Construction Site", "Cruise Ship", "Embassy", "Farm", "Gas Station", "High School", "Hospital", "Hot Air Balloon", "Hotel", "Jail", "Jazz Club", "Library",
  "Military Base", "Movie Studio", "Nightclub", "Ocean Liner", "Train", "Pirate Ship", "Police Station", "Race Track", "Restaurant", "Retirement Home",
  "School", "Spa", "Space Station", "Stadium", "Submarine", "Supermarket", "University", "Wedding", "Zoo"];