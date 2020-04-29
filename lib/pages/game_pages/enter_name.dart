import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spyfall/services/database.dart';
import 'package:spyfall/shared/constants.dart';

class EnterName extends StatefulWidget {
  @override
  _EnterNameState createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {

  String creatorID;
  var passedParams;
  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');
  final CollectionReference userLocationsCollection = Firestore.instance.collection('userLocations');
  String name = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      passedParams = ModalRoute.of(context).settings.arguments;
      creatorID = passedParams['deviceID'];
      //setting accessCode after game is created
      //await createNewGame(creatorID).then((code) => accessCode = code);
    });
  }

//this code will call the function createNewGame from the DatabaseService class to overwrite/write a new doc representing a game in spyfall
  Future<int> createNewGame(String creatorID, String name) async {

    //generating the random access code
    var rand = Random();
    int randomCode = (100000 +  rand.nextDouble() * 900000).floor();

    //if a document with this accessCode exists, we must generate a new access code
    while(await _codeIsUnique(randomCode) == false){
      randomCode = (100000 +  rand.nextDouble() * 900000).floor();
    }

    //the active locations will be used as the unusedlocations to start the game
    List<String> unusedLocations = await userLocationsCollection.document(this.creatorID).get().then(
      (docSnap) => List.from(docSnap.data['activeLocations'])
    );

    DatabaseService databaseService = DatabaseService(this.creatorID);
    //creating a new game document in firestore
    await databaseService.createNewGame(randomCode, this.name, unusedLocations);
    
    return randomCode;
  }

  //querying the activeGamesCollection to see if a game with this access code already exists
  Future<bool> _codeIsUnique(int code) async{
    //checking to see if the accessCode is already in use, if it is, false will be returned
    return await activeGamesCollection
      .where('accessCode', isEqualTo: code).getDocuments().then((query) => query.documents.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2C3D),
      appBar: AppBar(
        backgroundColor: Color(0xFF947C6A),
        title: Text('Spyfall'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Your Name'),
                textCapitalization: TextCapitalization.words,
                onChanged: (val) {
                  setState(() => name = val);
                },
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width/2.5,
                child: RaisedButton(
                  color: Color(0xFF947C6A),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  //when the name is not empty and only contains characters, a user can submit
                  onPressed: this.name != '' && RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(name) ? () async {
                    //when the button is pushed we will create a new game instance in firestore
                    //the createNewGame method will return the access code which will be passed to the NewGame widget
                    int accessCode;
                    await createNewGame(this.creatorID, this.name).then((code) => accessCode = code);
                    Navigator.pushNamed(context, '/new_game', arguments: {
                      'creatorID': creatorID,
                      'accessCode': accessCode,
                      'deviceID': creatorID,
                    });
                  }
                  :
                  null
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}