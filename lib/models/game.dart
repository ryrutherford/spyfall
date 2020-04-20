class Game {
  final int _accessCode;
  String _spyLocationGuess;
  final String _creatorID;
  final List<dynamic> _allPlayerIDsWithNames; /*Map<String,String>*/
  final List<String> _unusedLocations;
  final List<dynamic> _scoreTally; /*Map<String,int>*/
  String _spyID;
  Map<String,String> _accusationMap;
  String _currentLocation;
  bool _isActive;

  Game(this._accessCode, this._spyLocationGuess, this._creatorID, this._allPlayerIDsWithNames,
    this._unusedLocations, this._scoreTally, this._spyID, this._accusationMap, this._currentLocation, this._isActive);

  //getters
  int getAccessCode(){
    return this._accessCode;
  }

  String getSpyLocationGuess(){
    return this._spyLocationGuess;
  }

  String getCreatorID(){
    return this._creatorID;
  }

  List<String> getUnusedLocations(){
    return this._unusedLocations;
  }

  String getSpyID(){
    return this._spyID;
  }

  Map<String,String> getAccusationMap(){
    return this._accusationMap;
  }

  String getCurrentLocation(){
    return this._currentLocation;
  }

  bool getIsActive(){
    return this._isActive;
  }

  //returns a list of all the names of players in the game
  List<String> getListOfPlayers(){
    return this._allPlayerIDsWithNames.map((userInfo) {
      String name;
      for (var value in userInfo.values){
        name = value;
        break;
      }
      return name;
      }).toList();
  }

  //returns a list of all the names of players in the game with their score
  List<String> getScoreTally(){
    return this._scoreTally.map((scoreMap) {
      String result;
      for (var entry in scoreMap.entries){
        result = '${entry.key}: ${entry.value} ${entry.value == 1 ? 'point' : 'points'}';
        break;
      }
      return result;
      }).toList();
  }
}