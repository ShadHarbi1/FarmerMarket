import 'package:farmer_market/src/blocs/auth_bloc.dart';
import 'package:farmer_market/src/blocs/product_bloc.dart';
import 'package:farmer_market/src/screens/landing.dart';
import 'package:farmer_market/src/screens/login.dart';
import 'package:farmer_market/src/routes.dart';
import 'package:farmer_market/src/services/firestore_service.dart';
import 'package:farmer_market/src/styles/colors.dart';
import 'package:farmer_market/src/styles/text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

final authBloc = AuthBloc();
final productBloc = ProductBloc();
final firestoreService = FirestoreService();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => authBloc),
          Provider(create: (context) => productBloc),
          FutureProvider(
            create: (context) => authBloc.isLoggedIn(),
            initialData: null,
          ),
          StreamProvider(
            create: (context) => firestoreService.fetchUnitTypes(),
            initialData: null,
          )
        ],
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return PlatformApp();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  @override
  void dispose() {
    authBloc.dispose();
    productBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
          home: (isLoggedIn == null)
              ? loadingScreen(true)
              : (isLoggedIn == true)
                  ? Landing()
                  : Login(),
          onGenerateRoute: Routes.cupertinoRoutes,
          theme: CupertinoThemeData(
              primaryColor: AppColors.straw,
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                  tabLabelTextStyle: TextStyles.suggestion)));
    } else {
      return MaterialApp(
          home: (isLoggedIn == null)
              ? loadingScreen(false)
              : (isLoggedIn == true)
                  ? Landing()
                  : Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white));
    }
  }

  Widget loadingScreen(bool isIOS) {
    return (isIOS)
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
