import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/locations.dart';
import 'package:spyfall/pages/home/location_tile.dart';
import 'package:spyfall/shared/constants.dart';

class LocationsForm extends StatefulWidget {
  @override
  _LocationsFormState createState() => _LocationsFormState();
}

class _LocationsFormState extends State<LocationsForm> {
  
  final _formKey = GlobalKey<FormState>();

  void _addLocation(String locationName) async {

  }

  //form values
  String _locationName = '';
  
  @override
  Widget build(BuildContext context) {

    //size of display area
    var size = MediaQuery.of(context).size;
    
    final userLocations = Provider.of<Locations>(context);
    List<String> activeLocations = [];
    List<String> inactiveLocations = [];

    if(userLocations != null){
      activeLocations = userLocations.getActiveLocations();
      inactiveLocations = userLocations.getInactiveLocations();
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height:20.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Enter Location Name'),
              textCapitalization: TextCapitalization.words,
              validator: (val) => val.isEmpty ? 'Please Enter a Name' : null,
              onChanged: (val) {
                setState(() => _locationName = val);
              },
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height:20.0),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width/2.5,
              child: RaisedButton(
                color: Color(0xFF947C6A),
                onPressed: RegExp(r'^[a-zA-Z0-9]+$').hasMatch('$_locationName') && _locationName != '' ? () async {
                  _addLocation(_locationName);
                }
                :
                null,
                child: Text(
                  'Add Location',
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
              ),
            ),
            SizedBox(height:20.0),
            Text(
              'Active Locations',
              style: TextStyle(
                color: Colors.white,
              )
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: ((size.width) / size.height),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(activeLocations.length, (index) => LocationTile(location: activeLocations[index]))
              ),
            ),
            SizedBox(height:20.0),
            Text(
              'Inactive Locations',
              style: TextStyle(
                color: Colors.white,
              )
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: ((size.width) / size.height),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(inactiveLocations.length, (index) => LocationTile(location: inactiveLocations[index]))
              ),
            ),
          ],
        ),
      ),
    );
  }
}