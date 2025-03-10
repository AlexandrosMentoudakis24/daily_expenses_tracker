import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:daily_expense_tracker/utils/constants/web_server_uri_constants.dart';
import 'package:daily_expense_tracker/widgets/_myApp/my_app.dart';

void main() {
  const serverUri = String.fromEnvironment(
    "SERVER_URI",
    defaultValue: "https://daily-expenses-tracker-backend.vercel.app",
  );

  WebServer.setServerUri(
    serverUri,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
