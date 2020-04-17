class Game {
  final int accessCode;
  String spyLocationGuess;
  final String creatorID;
  final List<dynamic> allPlayerIDsWithNames; /*Map<String,String>*/
  final List<String> unusedLocations;
  final List<dynamic> scoreTally; /*Map<String,int>*/
  String spyID;
  Map<String,String> accusationMap;
  String currentLocation;
  bool isActive;

  Game(this.accessCode, this.spyLocationGuess, this.creatorID, this.allPlayerIDsWithNames,
    this.unusedLocations, this.scoreTally, this.spyID, this.accusationMap, this.currentLocation, this.isActive);

  //returns a list of all the names of players in the game
  List<String> getListOfPlayers(){
    return this.allPlayerIDsWithNames.map((userInfo) {
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
    return this.scoreTally.map((scoreMap) {
      String result;
      for (var entry in scoreMap.entries){
        result = '${entry.key}: ${entry.value} ${entry.value == 1 ? 'point' : 'points'}';
        break;
      }
      return result;
      }).toList();
  }
}