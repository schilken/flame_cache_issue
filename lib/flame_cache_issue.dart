import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class FlameCacheIssue extends FlameGame with HasTappables{
  FlameCacheIssue();

  @override
  Future<void> onLoad() async {
    add(TappableSquare(onTapped: playSoundEffect)..anchor = Anchor.center);
    final sfxNames = ['pha.mp3'];
    await FlameAudio.audioCache.loadAll(sfxNames);
  }

  void playSoundEffect() {
    FlameAudio.play('pha.mp3', volume: 1.0);
  }
  
}

class TappableSquare extends PositionComponent with Tappable {
  static final Paint _white = Paint()..color = const Color(0xFFFFFFFF);
  static final Paint _grey = Paint()..color = const Color(0xFFA5A5A5);

  bool _beenPressed = false;

  TappableSquare({Vector2? position, required this.onTapped})
      : super(
          position: position ?? Vector2.all(100),
          size: Vector2.all(100),
        );

VoidCallback onTapped;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _beenPressed ? _grey : _white);
  }

  @override
  bool onTapUp(info) {
    _beenPressed = !_beenPressed;
    onTapped();
    return true;
  }

  @override
  bool onTapCancel() {
    _beenPressed = false;
    return true;
  }
}
