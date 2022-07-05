import 'dart:async';

import 'package:chatter/app.dart';
import 'package:chatter/screens/home_screen.dart';
import 'package:chatter/screens/sign_in_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SplashScreen extends StatefulWidget {
  static Route get route {
    logger.i("nav to SplashScreen");
    return MaterialPageRoute(
      builder: (context) => const SplashScreen(),
      maintainState: false,
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final StreamSubscription<firebase.User?> listener;
  final functions = FirebaseFunctions.instanceFor(region: "europe-west3");

  @override
  void initState() {
    super.initState();
    _handleAuthenticatedState();
  }

  Future<void> _handleAuthenticatedState() async {
    logger.i("_handleAuthenticatedState");

    final auth = firebase.FirebaseAuth.instance;
    if (!mounted) {
      return;
    }

    final currentFirebaseUser = auth.currentUser;
    logger.i("splash screen currentFirebaseUser: $currentFirebaseUser");
    if (currentFirebaseUser == null) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
    }

    listener = auth.authStateChanges().listen((firebaseUser) async {
      logger.i("splash screen authState changed: $firebaseUser");

      if (firebaseUser != null) {
        // Create Stream user and get token using Firebase Functions
        final callable = functions.httpsCallable('setStreamUserAndGetToken');
        final result = await callable.call();

        logger.d("setStreamUserAndGetToken function result: $result");

        // Connect user to Stream and set user data
        final client = StreamChatCore.of(context).client;
        final ownUser = await client.connectUser(
          User(
            id: firebaseUser.uid,
            name: firebaseUser.phoneNumber,
          ),
          result.data,
        );

        logger.d("stream user: $ownUser");

        // authenticated
        Navigator.of(context).pushReplacement(HomeScreen.route);
      } else {
        Navigator.of(context).pushReplacement(AppSignInScreen.route);
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
