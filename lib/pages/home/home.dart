import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spyfall/models/locations.dart';
import 'package:spyfall/pages/home/locations/locations_form.dart';
import 'package:spyfall/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String deviceID;
  List<dynamic> activeLocations, inactiveLocations;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //extracting the deviceID that was retrieved when the app first loaded
      Map argMap = ModalRoute.of(context).settings.arguments;
      deviceID = argMap['deviceID'];
      activeLocations = argMap['activeLocations'];
      inactiveLocations = argMap['inactiveLocations'];
    });
  }  

  @override
  Widget build(BuildContext context) {

    void _showLocationsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color(0xFF2F2C3D),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: StreamProvider<Locations>.value(
            value: DatabaseService(this.deviceID).userLocations,
            child: LocationsForm(this.deviceID)
          ),
        );
      });
    }
    
    return Scaffold(
      appBar: AppBar(
          title: Text('Spyfall'),
          backgroundColor: Color(0xFF947C6A),
          centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF2F2C3D),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width/2.5,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/enter_name', arguments: {'deviceID': deviceID});
                    },
                    child: Text(
                      'New Game', 
                       style: TextStyle(
                         color: Colors.white,
                         )
                        ),
                    color: Color(0xFF947C6A),//Colors.purple[700],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width/2.5,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/join_game', arguments: {'deviceID': deviceID});
                    },
                    color: Color(0xFF947C6A),
                    child: Text(
                      'Join Game', 
                      style: TextStyle(
                        color: Colors.white,
                      )
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width/2.5,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'About', 
                       style: TextStyle(
                         color: Colors.white,
                         )
                        ),
                    color: Color(0xFF947C6A),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //original: https://i.pinimg.com/originals/d5/0c/7b/d50c7b0413ac64fd5653c6b97cef9a22.gif
                Image.asset('assets/images/SPYIMAGE.gif', width: MediaQuery.of(context).size.height/4, height: MediaQuery.of(context).size.height/4),
              ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLocationsPanel(),
        child: Icon(Icons.edit_location),
        backgroundColor: Color(0xFF947C6A),
      ),
    );
  }
}