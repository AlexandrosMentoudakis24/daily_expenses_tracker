import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/utils/constants/web_server_uri_constants.dart';
import 'package:daily_expense_tracker/widgets/_myApp/my_app.dart';

void main() {
  WebServer.setServerUri(
    "https://daily-expenses-tracker-backend.vercel.app",
  );
  //WebServer.setServerUri(
  //  "http://192.168.31.64:8080", // xiaomi wifi network
  //);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
