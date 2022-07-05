import 'package:chatter/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authRepoProvider =
    Provider.autoDispose<AuthRepo>((ref) => FirebaseAuthRepo());

abstract class AuthRepo {
  String get uid;

  String? get profileName;

  String? get profilePictureUrl;

  String get phoneNumber;

  Future<void> signOut();

  Future<void> changeProfileName({required String newProfileName});

  Future<void> changeProfilePicture({required XFile newProfilePicture});
}

class FirebaseAuthRepo implements AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _profilePicStorageRef = FirebaseStorage.instance.ref("profilePictures");

  @override
  String get phoneNumber {
    final phoneNr = _auth.currentUser?.phoneNumber;

    if (phoneNr == null) {
      throw Exception("Phone number not found");
    }

    return phoneNr;
  }

  @override
  String get uid {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      throw Exception("UID not found");
    }

    return uid;
  }

  @override
  String? get profileName => _auth.currentUser?.displayName;

  @override
  String? get profilePictureUrl => _auth.currentUser?.photoURL;

  @override
  Future<void> changeProfileName({required String newProfileName}) async {
    logger.i("Changing profile name to $newProfileName");
    await _auth.currentUser?.updateDisplayName(newProfileName);
    //ToDo: update StreamChatCore
  }

  @override
  Future<void> changeProfilePicture({required XFile newProfilePicture}) async {
    logger.i("Changing profile picture to $newProfilePicture");
    //ToDo: store picture in Firebase Storage
    final unit8File = await newProfilePicture.readAsBytes();
    final pictureUrlSnap = await _profilePicStorageRef.putData(unit8File);
    final downloadUrl = await pictureUrlSnap.ref.getDownloadURL();

    await _auth.currentUser?.updatePhotoURL(downloadUrl);
    //ToDo: update StreamChatCore
  }

  @override
  Future<void> signOut() async {
    logger.i("Signing out");
    await _auth.signOut();
  }
}
