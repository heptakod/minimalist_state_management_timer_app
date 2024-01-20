//import 'dart:async';

import 'notifiers/button_notifier.dart';
import 'notifiers/time_left_notifier.dart';

class TimerPageManager {
  // state notifiers

  final buttonNotifier = ButtonNotifer();
  final timeLeftNotifier = TimeLeftNotifier(10);

  void initTimerState() {
    timeLeftNotifier.initialize();
  }

  String getInitialTimerValue() {
    return timeLeftNotifier.initialValue.toString();
  }

  void start() {
    if (buttonNotifier.value == ButtonState.paused) {
      _unpauseTimer();
    } else {
      _startTimer();
    }
  }

  void _unpauseTimer() {
    buttonNotifier.value = ButtonState.started;
    timeLeftNotifier.unpause();
  }

  void _startTimer() {
    buttonNotifier.value = ButtonState.started;
    timeLeftNotifier.start(onDone: () {
      buttonNotifier.value = ButtonState.finished;
    });
  }

  void pause() {
    timeLeftNotifier.pause();
    buttonNotifier.value = ButtonState.paused;
  }

  void reset([int? time]) {
    timeLeftNotifier.reset(time);
    buttonNotifier.value = ButtonState.initial;
  }

  void dispose() {
    timeLeftNotifier.dispose();
  }
}
