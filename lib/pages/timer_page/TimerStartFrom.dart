import 'package:flutter/material.dart';
import 'package:timer_app/pages/timer_page/timer_page_logic.dart';

import '../../services/service_locator.dart';

class TimerStartFrom extends StatefulWidget {
  const TimerStartFrom({Key? key}) : super(key: key);

  @override
  State<TimerStartFrom> createState() => _TimerStartFromState();
}

class _TimerStartFromState extends State<TimerStartFrom> {
  final controller = TextEditingController();
  final myFocusNode = FocusNode();
  final stateManager = getIt<TimerPageManager>();

  @override
  void initState() {
    controller.text = stateManager.getInitialTimerValue();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build entered!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            controller: controller,
            focusNode: myFocusNode,
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton.icon(
          label: Text(''),
          onPressed: () {
            stateManager.reset(int.parse(controller.text));
            myFocusNode.unfocus();
          },
          icon: Icon(Icons.check),
        ),
      ],
    );
  }
}
