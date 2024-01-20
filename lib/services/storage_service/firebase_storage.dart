import 'dart:convert';

import 'package:timer_app/services/storage_service/storage_service.dart';
import 'package:http/http.dart' as http;

class FirebaseStorage extends StorageService {
  //final Uri url = Uri.https('karacuhaapp-default-rtdb.firebaseio.com', 'timer-app.json');
  @override
  Future<int?> getTimeLeft() async {
    final Uri url = Uri.https('karacuhaapp-default-rtdb.firebaseio.com', 'timer-app/-NcqnDc6KCzu_ky3UAdR/timeLeft.json');
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later.';
      // });
      throw Exception('Failed to fetch data. Please try again later.');
    }
    if (response.body == 'null') {
      return 0;
    }
    final int timeLeft = json.decode(response.body) as int;
    print(response.body);
    // print(listData['-NcqnDc6KCzu_ky3UAdR']['timeLeft']);
    return timeLeft;
  }

  @override
  Future<void> saveTimeLeft(int seconds) async {
    final Uri url = Uri.https('karacuhaapp-default-rtdb.firebaseio.com', 'timer-app/-NcqnDc6KCzu_ky3UAdR/.json');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'timeLeft': seconds}),
    );
    print(response.body);
  }
}
