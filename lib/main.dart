import 'package:flutter/material.dart';
import 'package:spyfall/pages/game_pages/active_game.dart';
import 'package:spyfall/pages/game_pages/enter_name.dart';
import 'package:spyfall/pages/game_pages/join_game.dart';
import 'package:spyfall/pages/game_pages/new_game.dart';
import 'package:spyfall/pages/home/home.dart';
import 'package:spyfall/pages/home/loading.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/enter_name': (context) => EnterName(),
    '/new_game': (context) => NewGame(),
    '/join_game': (context) => JoinGame(),
    '/active_game': (context) => ActiveGame(),
  }
));
