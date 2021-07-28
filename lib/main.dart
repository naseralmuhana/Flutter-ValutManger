import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:password_manager/pages/authenticate/finger_print_auth.dart';

import 'package:password_manager/services/routes.dart';
import 'package:password_manager/services/themes.dart';
import 'package:password_manager/widgets/bottomBar/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData,
      initialRoute: BottomBarWidget.routeName,
      routes: routes,
    );
  }
}
