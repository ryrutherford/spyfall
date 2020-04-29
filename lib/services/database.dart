import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spyfall/models/game.dart';
import 'package:spyfall/models/locations.dart';

class DatabaseService {
  
  final String creatorID;
  DatabaseService(this.creatorID);

  //collection reference
  final CollectionReference activeGamesCollection = Firestore.instance.collection('activeGames');
  final CollectionReference userLocationsCollection = Firestore.instance.collection('userLocations');

  Future createNewGame(int accessCode, String name, List<String> unusedLocations) async{

    //overwriting or writing a new document with id as the creatorID and the following data
    return await activeGamesCollection.document(creatorID).setData({
      'accessCode': accessCode,
      'accusationMap': {},
      'allPlayerIDsWithNames': [{'$creatorID': name}],
      'creatorID': this.creatorID,
      'currentLocation': '',
      'scoreTally': [],
      'spyID': '',
      'spyLocationGuess': '',
      'unusedLocations': unusedLocations,
      'isActive': false,
      'playerSpyGuess': '',
    });
  }

  Future addAccusation(String docID, Map<String,String> accusation) async{
    return await activeGamesCollection.document(docID).updateData({

    });
  }

  //returns a Game object from a document snapshot
  Game _gameFromDocSnap(DocumentSnapshot snapshot){
    var data = snapshot.data;
    print('making new game object');
    return  Game(data['accessCode'], data['spyLocationGuess'], data['creatorID'], data['allPlayerIDsWithNames'],
      List.from(data['unusedLocations']), data['scoreTally'], data['spyID'], Map.from(data['accusationMap']), data['currentLocation'],
      data['isActive']);
  }

  //get active game stream
  Stream<Game> get activeGame {
    return activeGamesCollection.document(this.creatorID).snapshots().map(_gameFromDocSnap);
  }


  Locations _locationsFromDocSnap(DocumentSnapshot snapshot){
    var data = snapshot.data;
    List<String> activeLocations = List.from(data['activeLocations']);
    activeLocations.sort((a, b) => a.toString().compareTo(b.toString()));
    List<String> inactiveLocations = List.from(data['inactiveLocations']);
    inactiveLocations.sort((a, b) => a.toString().compareTo(b.toString()));
    return Locations(activeLocations, inactiveLocations, data['remindUser']);
  }

  //get user locations
  Stream<Locations> get userLocations {
    return userLocationsCollection.document(this.creatorID).snapshots().map(_locationsFromDocSnap);
  }

}