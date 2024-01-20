import 'package:flutter/material.dart';
import 'package:timer_app/pages/timer_page/TimerStartFrom.dart';
import 'package:timer_app/services/service_locator.dart';
import 'package:timer_app/pages/timer_page/timer_page_logic.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import 'notifiers/button_notifier.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final stateManager = getIt<TimerPageManager>();

  @override
  void initState() {
    stateManager.initTimerState();
    super.initState();
  }

  @override
  void dispose() {
    stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('building MyHomePage');
    return Scaffold(
      appBar: AppBar(title: const Text('My Timer App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TimerStartFrom(),
            const SizedBox(height: 20),
            TimerTextWidget(),
            const SizedBox(height: 20),
            ButtonsContainer(),
          ],
        ),
      ),
    );
  }
}

class TimerTextWidget extends StatelessWidget with GetItMixin {
  TimerTextWidget({super.key});
  @override
  Widget build(BuildContext context) {
    //final stateManager = getIt<TimerPageManager>();
    final timeLeft = watchX((TimerPageManager x) => x.timeLeftNotifier);

    print('building time left state: $timeLeft');
    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class ButtonsContainer extends StatelessWidget with GetItMixin {
  ButtonsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    //final stateManager = getIt<TimerPageManager>();
    final buttonState = watchX((TimerPageManager x) => x.buttonNotifier);
    print('building button state: $buttonState');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (buttonState == ButtonState.initial) ...[
          const StartButton(),
        ],
        if (buttonState == ButtonState.started) ...[
          const PauseButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (buttonState == ButtonState.paused) ...[
          const StartButton(),
          const SizedBox(width: 20),
          const ResetButton(),
        ],
        if (buttonState == ButtonState.finished) ...[
          const ResetButton(),
        ],
      ],
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.start();
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.pause();
      },
      child: const Icon(Icons.pause),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.reset();
      },
      child: const Icon(Icons.replay),
    );
  }
}
