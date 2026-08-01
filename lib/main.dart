import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/navigation_screen.dart';
import 'services/database_initializer.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQLite nur auf Android, iOS und Windows starten
  if (!kIsWeb) {
    await DatabaseInitializer.initialize();
  }

  runApp(const FluidTrackApp());
}

class FluidTrackApp extends StatelessWidget {
  const FluidTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluid Track AWH',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const NavigationScreen(),
    );
  }
}