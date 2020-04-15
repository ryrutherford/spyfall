import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String deviceID, deviceIDErrorMSG;

  @override
  Widget build(BuildContext context) {

    //extracting the deviceID that was retrieved when the app first loaded
    Map argMap = ModalRoute.of(context).settings.arguments;
    try{
      deviceID = argMap['deviceID'];
      print(deviceID);
    }
    catch(e){
      deviceIDErrorMSG = argMap['deviceIDErrorMSG'];
      print(deviceIDErrorMSG);
    }

    return Scaffold(
      appBar: AppBar(
          title: Text('Spyfall'),
          centerTitle: true,
          backgroundColor: Color(0xFF947C6A),
      ),
      body: Container(
        color: Color(0xFF2F2C3D),//Colors.grey[850],
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
                      Navigator.pushNamed(context, '/new_game');
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
                      Navigator.pushNamed(context, '/join_game');
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
    );
  }
}