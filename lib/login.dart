import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'page1.dart';

class Log extends StatefulWidget {
  static const String route = 'Login';

  @override
  Login createState() => Login();
}

class Login extends State<Log> {
  final Map<String, String> users = {
    'aaaa': '1111',
    'bbbb': '2222',
    'cccc': '3333',
    'dddd': '4444',
  };

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  void checker() {
    final String username = _userName.text;
    final String password = _passWord.text;
    if (users.containsKey(username) && users[username] == password) {
      Navigator.pushNamed(context, Page1.route);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Login',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(color: AppTheme.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.darkPrimary,
                AppTheme.lightPrimary.withOpacity(0.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.lightPrimary,
              AppTheme.darkPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _userName,
                  style: TextStyle(color: AppTheme.black),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: AppTheme.darkPrimary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.darkPrimary),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.darkPrimary),
                    ),
                  ),
                  onSubmitted: (value) => checker(),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passWord,
                  obscureText: true,
                  style: TextStyle(color: AppTheme.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: AppTheme.darkPrimary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.darkPrimary),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.darkPrimary),
                    ),
                  ),
                  onSubmitted: (value) => checker(),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Functionality to reset password is not implemented yet.'),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: AppTheme.darkPrimary),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: checker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkPrimary,
                    foregroundColor: AppTheme.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Enter',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(color: AppTheme.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
