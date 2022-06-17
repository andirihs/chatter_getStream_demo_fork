import 'package:chatter/app.dart';
import 'package:chatter/screens/splash_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class AppSignInScreen extends StatelessWidget {
  AppSignInScreen({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (context) => AppSignInScreen());

  final auth = FirebaseAuth.instance;
  final functions = FirebaseFunctions.instanceFor(region: "europe-west3");

  // const PhoneProviderConfiguration().createFlow(null, AuthAction.signIn),
  @override
  Widget build(BuildContext context) {
    final providerConfigs = [
      const PhoneProviderConfiguration(),
    ];

    return SignInScreen(
      providerConfigs: providerConfigs,
      headerBuilder: headerIcon(Icons.link),
      sideBuilder: sideIcon(Icons.link),
      showAuthActionSwitch: false,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          final firebaseUser = state.user;
          logger.d("AuthStateChangeAction | firebaseUser: $firebaseUser");

          await Navigator.pushReplacement(
            context,
            SplashScreen.route,
          );
        }),
      ],
    );
  }
}

HeaderBuilder headerIcon(IconData icon) {
  return (context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(top: 40),
      child: Icon(
        icon,
        size: constraints.maxWidth / 4 * (1 - shrinkOffset),
      ),
    );
  };
}

SideBuilder sideIcon(IconData icon) {
  return (context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Icon(
        icon,
        size: constraints.maxWidth / 3,
      ),
    );
  };
}
