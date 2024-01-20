import 'package:flutter/material.dart';

class ButtonNotifer extends ValueNotifier<ButtonState> {
  ButtonNotifer() : super(ButtonState.initial);
}

enum ButtonState {
  initial,
  started,
  paused,
  finished,
}
