import 'package:flutter/material.dart';

import 'package:daily_expense_tracker/widgets/_myApp/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
