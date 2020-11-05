import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beat_box/screens/home_screen.dart';
import 'package:beat_box/screens/login_screen.dart';
import 'package:beat_box/screens/registration_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class MyApp extends StatefulWidget {
  MyApp() {
    // isLoggedIn = auth.currentUser != null;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    print('hi');
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      print(deepLink);
      // if (deepLink != null) {
      //   Navigator.pushNamed(context, deepLink.path);
      // }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    print(deepLink);
    // if (deepLink != null) {
    //   Navigator.pushNamed(context, deepLink.path);
    // }
  }

  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: auth.currentUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
      home: LoginScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
      },
    );
  }
}
