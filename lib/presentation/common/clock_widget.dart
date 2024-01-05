import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late String currentTime;
  late String welcomeMessage;

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
  }

  void _getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);

    setState(() {
      currentTime = formattedTime;

      // Set welcome message based on the time
      if (now.hour < 12) {
        welcomeMessage = 'Good morning';
      } else if (now.hour < 18) {
        welcomeMessage = 'Good afternoon';
      } else {
        welcomeMessage = 'Good evening';
      }
    });

    // Update time every minute (60 seconds)
    Future.delayed(const Duration(seconds: 60), _getCurrentTime);
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat.Hm()
        .format(dateTime); // Format 'Hm' wyświetla godzinę i minuty
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currentTime,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        Text(welcomeMessage,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
      ],
    );
  }
}
