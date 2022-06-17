import 'package:chatter/app.dart';
import 'package:chatter/pages/contacts_page.dart';
import 'package:chatter/pages/messages_page.dart';
import 'package:chatter/screens/profile_screen.dart';
import 'package:chatter/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final pages = const [
    MessagesPage(),
    ContactsPage(),
  ];

  final pageTitles = const [
    'Messages',
    'Homes',
  ];

  void _showContactsPopUp(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => const Dialog(
        child: AspectRatio(
          aspectRatio: 8 / 7,
          child: ContactsPage(),
        ),
      ),
    );
  }

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) => Text(value),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 2,
            backgroundImage: const AssetImage('assets/logo/logo_molz.png'),
            backgroundColor: Theme.of(context).cardColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => logger.i('TODO search'),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showContactsPopUp(context),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 24.0),
          //   child: Hero(
          //     tag: 'hero-profile-picture',
          //     child: Avatar.small(
          //       url: context.currentUserImage,
          //       onTap: () => Navigator.of(context).push(ProfileScreen.route),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) => pages[value],
      ),
      // bottomNavigationBar: AppBottomNavigationBar(
      //   onItemSelected: _onNavigationItemSelected,
      // ),
      bottomNavigationBar: MaterialBottomNavBat(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class MaterialBottomNavBat extends StatefulWidget {
  const MaterialBottomNavBat({required this.onItemSelected, Key? key})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<MaterialBottomNavBat> createState() => _MaterialBottomNavBatState();
}

class _MaterialBottomNavBatState extends State<MaterialBottomNavBat> {
  int selectedIndex = 0;

  void handleItemSelected(int index) {
    /// not not navigate if profile is selected
    if (index != 2) {
      setState(() => selectedIndex = index);
      widget.onItemSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        const NavigationDestination(
          icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill),
          label: 'Messages',
        ),
        const NavigationDestination(
          icon: Icon(CupertinoIcons.person_2_fill),
          label: 'Homes',
        ),
        NavigationDestination(
          icon: Hero(
            tag: 'hero-profile-picture',
            child: Avatar.small(
              url: context.currentUserImage,
              onTap: () => Navigator.of(context).push(ProfileScreen.route),
            ),
          ),
          label: "profile",
        )
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: handleItemSelected,
      elevation: 3,
      backgroundColor: Colors.transparent,
    );
  }
}
