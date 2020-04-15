import 'package:flutter/material.dart';
import 'package:spyfall/pages/home.dart';
import 'package:spyfall/pages/loading.dart';
import 'package:spyfall/pages/new_game.dart';
import 'package:spyfall/pages/join_game.dart';
import 'package:spyfall/pages/active_game.dart';


void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/new_game': (context) => NewGame(),
    '/join_game': (context) => JoinGame(),
    '/active_game': (context) => ActiveGame(),
  }
));
