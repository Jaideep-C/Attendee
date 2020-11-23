import 'package:attandee/global/screens/home_page.dart';
import 'package:attandee/global/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global/models/token.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => Token(),
        child: IsAuth(),
      ),
    ),
  );
}

class IsAuth extends StatefulWidget {
  @override
  _IsAuthState createState() => _IsAuthState();
}

class _IsAuthState extends State<IsAuth> {
  @override
  Widget build(BuildContext context) {
    Token token = context.watch<Token>();
    print(token.id);
    return (token.id == '' || token.id == null) ? LoginPage() : HomePage();
  }
}
