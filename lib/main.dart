import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'createaccount.dart';
import 'login.dart';
import 'page1.dart';
import 'balance.dart';
import 'page3.dart';
import 'home.dart';
import 'settings.dart';
import 'SettingsProvider.dart';
import 'app_theme.dart';
import 'cart_page.dart';
void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SettingsProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,
      initialRoute: Home.route,
      routes: {
        CreateAccount.route: (context) => CreateAccount(),
        Home.route: (context) => Home(),
        Log.route: (context) => Log(),
        Page1.route: (context) => Page1(),
        Balance.route: (context) => Balance(),
        Page3.route: (context) => Page3(),
        SettingsPage.route: (context) =>SettingsPage (),
        CartPage.route:(context) =>CartPage (),
      },
    );
  }
}
