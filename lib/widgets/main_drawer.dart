import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/functions/n_push_and_remove_until.dart';
import 'package:technical_store/providers/settings_provider.dart';
import 'package:technical_store/screens/home_screen.dart';
import 'package:technical_store/screens/profile_screen.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

String getName(String name) {
  if (name == '') {
    return 'Имя';
  }
  return name;
}

String getAddress(String address) {
  if (address == '') {
    return 'Адрес';
  }
  return address;
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 70,
            child: DrawerHeader(
              child: Text('Меню', style: theme.textTheme.bodyMedium),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Главная', style: theme.textTheme.bodySmall),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) {
                    return Home();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Профиль', style: theme.textTheme.bodySmall),
            onTap: () {
              nPushAndRemoveUntil(
                context,
                ProfileScreen(
                  number: settingsProvider.settings['number'],
                  address: settingsProvider.settings['address'],
                  name: settingsProvider.settings['name'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
