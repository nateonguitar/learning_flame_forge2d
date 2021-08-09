import 'package:flame/components.dart';
import 'package:flame/gestures.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/position_body_component.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent with Tappable {
  late _PlayerBodyComponent positionBodyComponent;
  Paint _paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  Player({required Vector2 initialSize, required Vector2 initialPosition}) {
    size = initialSize;
    position = initialPosition;
    anchor = Anchor.center;
    positionBodyComponent = _PlayerBodyComponent(this, size);
  }

  @override
  Future<void>? onLoad() async {
    return super.onLoad();
  }
  
  @override
  void update(double dt) {
    position = positionBodyComponent.body.position.clone();
    super.update(dt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    positionBodyComponent.body.applyLinearImpulse(Vector2(25, 50));
    return true;
  }

  @override
  void render(Canvas canvas) {
    // super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(position.x - size.x / 2, (-position.y) - size.y / 2, size.x, size.y),
      _paint,
    );
  }
}

class _PlayerBodyComponent extends PositionBodyComponent {

  _PlayerBodyComponent(
    PositionComponent positionComponent,
    Vector2 size,
  ) : super(positionComponent, size);

  @override
  Body createBody() {
    PolygonShape shape = PolygonShape()..setAsBoxXY(size.x / 2, size.y / 2);
    final FixtureDef fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..friction = 1;
    final BodyDef bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..fixedRotation = false
      ..position = camera.screenToWorld(positionComponent.position);
    Body b = world.createBody(bodyDef)
      ..createFixture(fixtureDef)
      ..gravityScale = 10;
    return b;
  }
}
