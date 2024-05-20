import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oatto_ecommerce_statemanagement/provider/oattomodel.dart';
import 'package:provider/provider.dart';

import 'layout/main-product.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OattoModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oatto E-Commerce',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        primaryColor: Colors.deepPurple,
        canvasColor: Theme.of(context).primaryColor,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: FlutterSplashScreen.scale(
        gradient: const LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple,
            Colors.blue,
          ],
        ),
        childWidget: SizedBox(
          height: 350,
          child: Image.asset("assets/images/hi.png"),
        ),
        duration: const Duration(milliseconds: 2500),
        animationDuration: const Duration(milliseconds: 2000),
        onAnimationEnd: () => debugPrint("On Scale End"),
        nextScreen: const MainProduct(),
      ),
    );
  }
}
