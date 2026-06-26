import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sokrio_user/core/di/injection_container.dart' as di;
import 'package:sokrio_user/core/theme/app_theme.dart';
import 'package:sokrio_user/presentation/providers/user_provider.dart';
import 'package:sokrio_user/presentation/pages/users_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => di.sl<UserProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Sokrio Users',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const UsersView(),
      ),
    );
  }
}
