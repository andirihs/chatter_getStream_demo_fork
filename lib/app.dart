import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// TODO: input your Stream app key here.
const streamKey = 'wfspt4kx6r77';

final logger = log.Logger();

/// Extensions can be used to add functionality to the SDK.
extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentFirebaseUser?.photoURL;
  auth.User? get currentFirebaseUser => auth.FirebaseAuth.instance.currentUser;

  User? get currentStreamUser => StreamChatCore.of(this).currentUser;
}
