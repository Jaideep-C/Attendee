import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global/models/token.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Token(),
      child: IsAuth(),
    ),
  );
}

class IsAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Token token = context.watch<Token>();

    // return (token.id=='' || token.id == null)? LoginPage():HomePage();

    return Container(
      child: Center(
        child: Text(token.id),
      ),
    );
  }
}
