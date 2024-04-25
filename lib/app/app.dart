import 'package:flutter/material.dart';
import 'package:kwcalculator/app/repository/repository.dart';
import 'package:kwcalculator/app/utils/kwtheme.dart';
import 'package:kwcalculator/app/view/help.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final KWTheme kwTheme = KWTheme();
    final Repository repository = Repository();

    return MaterialApp(
      title: 'KWCalculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kwTheme.primaryColor),
        scaffoldBackgroundColor: kwTheme.backgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Montserrat',
          bodyColor: kwTheme.textColor,
          displayColor: kwTheme.textColor,
        ),
        useMaterial3: true,
      ),
      home: HelpPage(initialPage: true,),
    );
  }
}