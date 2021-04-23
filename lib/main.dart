import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gg_keep_clone/providers/app_state_provider.dart';
import 'package:gg_keep_clone/providers/note_provider.dart';
import 'package:gg_keep_clone/screens/home_screen.dart';
import 'package:gg_keep_clone/screens/note_screen.dart';
import 'package:provider/provider.dart';

import 'screens/account_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/trash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteListProvider()),
      ChangeNotifierProvider(create: (_) => AppStateProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0043FF),
        accentColor: Color(0xFF00B0FF),
      ),
      home: HomeScreen(),
      routes: {
        NoteScreen.routeName: (_) => NoteScreen(),
        TrashScreen.routeName: (_) => TrashScreen(),
        SettingScreen.routeName: (_) => SettingScreen(),
        AccountScreen.routeName: (_) => AccountScreen(),
      },
    );
  }
}
