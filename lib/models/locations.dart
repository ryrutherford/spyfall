import 'package:spyfall/shared/constants.dart';

class Locations {
  List<String> activeLocations;
  List<String> inactiveLocations;
  static const List<String> defaultLocs = defaultLocations;

  Locations(this.activeLocations, this.inactiveLocations);

  List<String> getActiveLocations(){
    return this.activeLocations;
  }

  List<String> getInactiveLocations(){
    return this.inactiveLocations;
  }

}