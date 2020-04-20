import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spyfall/shared/constants.dart';

//need to handle case when error doesnt exist (add error message)

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  
  //the id of the current device
  String deviceID;
  //the passed parameters from the parent widget
  var passedParams;
  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');
  //the game access code entered by the user
  String _accessCode = '';
  //the name entered by the user
  String _name = '';
  //the error message to be displayed if the user tries to join an active game or uses an invalid code
  String _errorMsg;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //retrieving the deviceID from the parent widget
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      passedParams = ModalRoute.of(context).settings.arguments;
      deviceID = passedParams['deviceID'];
    });
    _errorMsg = '';
  }

  //a function that will connect a user to a new game as long as the access code is valid
  Future<String> _joinGame(int accessCode, String name) async {
    //the ID of the game creator, will be retrieved if the access code exists
    String creatorID = '';
    //the errorMsg to be returned
    String errorMsg = '';
    //the list of the players in the game
    List<dynamic> playersInGame;
    //a boolean indicating whether the game is active. if the game is active, you can't join the game
    bool isActive = true;
    await activeGamesCollection
      .where('accessCode', isEqualTo: accessCode)
        .getDocuments().then((query) {
            if(query.documents.isEmpty){
              errorMsg = 'The code ($accessCode) you entered was not valid. Please try again.';
              print('The code ($accessCode) you entered was not valid. Please try again.');
            }
            else{
              DocumentSnapshot ds = query.documents.removeLast();
              creatorID = ds.documentID;
              playersInGame = List.from(ds.data['allPlayerIDsWithNames']);
              isActive = ds.data['isActive'];
            }
          });

    //if the game is not active (isActive is false)
    if(!isActive){
      //check whether someone has already joined the game with this name
      bool nameExists = false;
      //getting a list of IDs
      List<String> idList = playersInGame.map((userInfo) {
        String id;
        for (var entry in userInfo.entries){
          id = entry.key;
          if(entry.value == name){
            nameExists = true;
          }
          break;
        }
        return id;
        }).toList();
      //if the player has already joined the game, they will just be redirected to the new game screen
      if(idList.contains(this.deviceID)){
        Navigator.pushNamed(context, '/new_game', arguments: {
          'creatorID': creatorID,
          'accessCode': accessCode
        });
      }
      else if(playersInGame.length < 10){
        //if the name has already been used, they must enter a new name
        if(nameExists){
          errorMsg = 'Someone has already joined the game with name $name. Please try a different name.';
          print('Someone has already joined the game with name $name. Please try a different name');
        }
        else{
          //add the player to the database
          playersInGame.add({
            '$deviceID': name
          });
          await activeGamesCollection.document(creatorID).updateData({
            'allPlayerIDsWithNames': playersInGame
          });

          //push to the new game screen
          Navigator.pushNamed(context, '/new_game', arguments: {
            'creatorID': creatorID,
            'accessCode': accessCode
          });
        }
      }
      else{
        errorMsg = 'The game has reached the maximum amount of players (10).';
        print('The game has reached the maximum amount of players (10)');
      }
    }
    //if the game is active 
    else if(creatorID != ''){
      errorMsg = 'The code you entered belongs to a game that\'s already active.';
      print('The code you entered belongs to a game that\'s already active.');
    }
    return errorMsg;
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
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Access Code'),
                textCapitalization: TextCapitalization.words,
                onChanged: (val) {
                  setState(() => _accessCode = val);
                },
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Name'),
                textCapitalization: TextCapitalization.words,
                onChanged: (val) {
                  setState(() => _name = val);
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
                  //when the name and access code are valid
                  onPressed: RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$').hasMatch(_accessCode) && _accessCode.length == 6 && RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(_name) ? () async {
                    await _joinGame(int.parse(_accessCode), _name).then((val) => setState(() => _errorMsg = val));
                    _formKey.currentState.reset();
                    print('error message: $this._errorMsg');
                  }
                  :
                  null
                ),
              ),
              Text(this._errorMsg, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,)
            ],
          ),
        ),
      )
    );
  }
}