import 'package:farmer_market/src/blocs/auth_bloc.dart';
import 'package:farmer_market/src/screens/login.dart';
import 'package:farmer_market/src/services/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

final authBloc = AuthBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [Provider(create: (context) => authBloc)],
        child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatefulWidget {
  @override
  _PlatformAppState createState() => _PlatformAppState();
}

class _PlatformAppState extends State<PlatformApp> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        home: Login(),
        onGenerateRoute: Routes.cupertinoRoutes,
      );
    } else {
      return MaterialApp(
        home: Login(),
        onGenerateRoute: Routes.materialRoutes,
      );
    }
  }
}
