import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forge2d/forge2d.dart';

import 'package:learning_flame_forge2d/ground.dart';
import 'package:learning_flame_forge2d/player.dart';

class TestPhysicsPage extends StatefulWidget {
  @override
  _TestPhysicsPageState createState() => _TestPhysicsPageState();
}

class _TestPhysicsPageState extends State<TestPhysicsPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GameWidget(game: TestPhysicsGame(screenSize));
  }
}

class TestPhysicsGame extends Forge2DGame with HasTappableComponents {
  late Ground _ground;
  late Player _player;
  final Size _screenSize;

  TestPhysicsGame(this._screenSize)
      : super(
          gravity: Vector2(0, -9.8),
          zoom: 1,
        );

  @override
  bool get debugMode => true;

  @override
  Future<void> onLoad() async {
    Vector2 center = Vector2(_screenSize.width / 2, _screenSize.height / 2);
    _ground = Ground(
        initialSize: Vector2(_screenSize.width / 2, 20),
        initialPosition: center.clone()..y = _screenSize.height * 0.75,
    );
    _player = Player(
        initialSize: Vector2(20, 20),
        initialPosition: center.clone()
        ..x = _screenSize.width / 2 - 205
        ..y = _screenSize.height * 0.5,
    );
    addAll([
      // _ground,
      _ground.positionBodyComponent,
      // _player,
      _player.positionBodyComponent,
    ]);
    // camera.followComponent(_player);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    world.stepDt(dt);
    super.update(dt);
  }

  @override
  Color backgroundColor() => Colors.transparent;
}
