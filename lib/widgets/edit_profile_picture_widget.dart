import 'package:chatter/repo/auth_repo.dart';
import 'package:chatter/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileWidget extends HookConsumerWidget {
  const EditProfileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Stack(
        children: const [
          ProfilePictureWidget(),
          Positioned(
            bottom: 0,
            right: 4,
            child: EditProfilePictureWidget(),
          ),
        ],
      ),
    );
  }
}

class ProfilePictureWidget extends ConsumerStatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends ConsumerState<ProfilePictureWidget> {
  // String? profilePictureUrl;

  Future<void> _editPicture() async {
    final _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await ref
          .read(authRepoProvider)
          .changeProfilePicture(newProfilePicture: image);

      setState(() {});
    }
  }

  @override
  void initState() {
    // profilePictureUrl = ref.read(authRepoProvider).profilePictureUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profilePictureUrl = ref.watch(authRepoProvider).profilePictureUrl;

    return profilePictureUrl != null
        ? ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: NetworkImage(profilePictureUrl),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(onTap: () {
                  _editPicture();
                }),
              ),
            ),
          )
        : Avatar(
            url: profilePictureUrl,
            onTap: () => _editPicture(),
            radius: 128 / 2,
          );
  }
}

class EditProfilePictureWidget extends ConsumerWidget {
  const EditProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add_a_photo,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 20,
        ),
      ),
    );
  }
}
