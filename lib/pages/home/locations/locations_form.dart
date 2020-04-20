import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/locations.dart';
import 'package:spyfall/pages/home/locations/locations_bottomsheet.dart';
import 'package:spyfall/shared/constants.dart';

class LocationsForm extends StatefulWidget {
  final String deviceID;

  const LocationsForm(this.deviceID);

  @override
  _LocationsFormState createState() => _LocationsFormState();
}

class _LocationsFormState extends State<LocationsForm> {

  final _formKey = GlobalKey<FormState>();
  final CollectionReference userLocationsCollection = Firestore.instance.collection('userLocations');

  //form values
  String _locationName = '';

  
  
  @override
  Widget build(BuildContext context) {
    
    final userLocations = Provider.of<Locations>(context);

    List<String> activeLocations;
    List<String> inactiveLocations;
    bool remindUser;
    if(userLocations != null){
      activeLocations = userLocations.getActiveLocations();
      inactiveLocations = userLocations.getInactiveLocations();
      remindUser = userLocations.getRemindUser();
    }

    //size of display area
    var size = MediaQuery.of(context).size;

    //addLocations method that adds a new location to the activeLocations
    void _addLocation(String locationName) async {
      if(userLocations != null){
        if(!activeLocations.contains(locationName) && !inactiveLocations.contains(locationName)){
          activeLocations.add(locationName);
          await userLocationsCollection.document(widget.deviceID).updateData({
            'activeLocations': activeLocations
          });
        }
        this.setState(() => _locationName = '');
      }
    }

    //bottom sheet for the active locations
    void _showActiveLocationsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF2F2C3D),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: LocationsBottomsheet(userLocations, true, widget.deviceID),
        );
      });
    }

    //bottom sheet for the inactive locations
    void _showInactiveLocationsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF2F2C3D),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: LocationsBottomsheet(userLocations, false, widget.deviceID)
        );
      });
    }

    void _alertDialog(BuildContext context, bool active) {
      // set up the buttons
      Widget dontRemindButton = FlatButton(
        child: Text("Don't Remind Me Again"),
        onPressed:  () async {
          await userLocationsCollection.document(widget.deviceID).updateData({
            'remindUser': false,
          });
          Navigator.of(context).pop(); // dismiss dialog
          if(active){
            _showActiveLocationsPanel();
          }
          else{
            _showInactiveLocationsPanel();
          }
        },
      );
      Widget okButton = FlatButton(
        child: Text("Ok"),
        onPressed:  () {
          Navigator.of(context).pop(); // dismiss dialog
          if(active){
            _showActiveLocationsPanel();
          }
          else{
            _showInactiveLocationsPanel();
          }
        },
      );
      // show the alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Tap on a location tile to change its active status.\nLong press on a location tile to delete it permanently"),
            actions: [
              dontRemindButton,
              okButton,
            ],
            elevation: 5,
          );
        },
      );
    }

    void _restoreDefaultLocations() async{
      await userLocationsCollection.document(widget.deviceID).updateData({
        'activeLocations': defaultLocations,
        'inactiveLocations': []
      });
    }

    return Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height:20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Location Name'),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) {
                    setState(() => _locationName = val);
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height:20.0),
                ButtonTheme(
                  minWidth: size.width/2.5,
                  child: RaisedButton(
                    color: Color(0xFF947C6A),
                    onPressed:  _locationName != '' ? () async {
                      _formKey.currentState.reset();
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
              ],
            ),
          ),
        ),
        SizedBox(height:20.0),
        ButtonTheme(
          minWidth: size.width/2.5,
          child: RaisedButton(
            color: Color(0xFF947C6A),
            onPressed: () {
              if(userLocations.getRemindUser()) _alertDialog(context, true);
              else _showActiveLocationsPanel();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'Active Locations',
              style: TextStyle(
                color: Colors.white,
              )
            ),
          ),
        ),
        ButtonTheme(
          minWidth: size.width/2.5,
          child: RaisedButton(
            color: Color(0xFF947C6A),
            onPressed: () {
              if(userLocations.getRemindUser()) _alertDialog(context, false);
              else _showInactiveLocationsPanel();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'Inactive Locations',
              style: TextStyle(
                color: Colors.white,
              )
            ),
          ),
        ),
        ButtonTheme(
          minWidth: size.width/2.5,
          child: OutlineButton(
            highlightColor: Colors.red,
            borderSide: BorderSide(color: Colors.white,),
            highlightedBorderColor: Color(0xFF947C6A),
            onPressed: () {
              _restoreDefaultLocations();
            },
            child: Text(
              'Restore Default Locations',
              style: TextStyle(
                color: Colors.white,
              )
            ),
          ),
        )
      ],
    );
  }
}