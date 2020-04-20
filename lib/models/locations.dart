import 'package:spyfall/shared/constants.dart';

class Locations {
  List<String> activeLocations;
  List<String> inactiveLocations;
  bool remindUser;
  static const List<String> defaultLocs = defaultLocations;

  Locations(this.activeLocations, this.inactiveLocations, this.remindUser);

  List<String> getActiveLocations(){
    return this.activeLocations;
  }

  List<String> getInactiveLocations(){
    return this.inactiveLocations;
  }

  bool getRemindUser(){
    return this.remindUser;
  }

}