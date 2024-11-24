import 'package:flutter/material.dart';
import 'SettingsProvider.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

class SettingsPage extends StatelessWidget {
  static const String route = 'SettingsPage';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/palestine2.jpg',
                height: 40,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.white),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                provider.isDark ? AppTheme.white : AppTheme.darkPrimary,
                provider.isDark ? AppTheme.gray : AppTheme.lightPrimary.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppTheme.darkPrimary),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              provider.isDark ? AppTheme.white : AppTheme.lightPrimary,
              provider.isDark ? AppTheme.gray : AppTheme.darkPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: TextStyle(color: AppTheme.black),
                ),
                value: provider.isDark,
                onChanged: (value) {
                  provider.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                },
                activeColor: AppTheme.darkPrimary,
              ),
              ListTile(
                title: Text(
                  'Language: ${provider.language}',
                  style: TextStyle(color: AppTheme.black),
                ),
                onTap: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
