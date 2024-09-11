import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeToggle = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
              title: Text(
                'Change Theme',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              value: themeToggle.themeModel.toggleTheme,
              onChanged: (val) {
                themeToggle.changeTheme();
              }),
          ListTile(
            title: Text(
              'Current Theme',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            trailing: Text(
              (themeToggle.themeModel.toggleTheme == false) ? 'Light' : 'Dark',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }
}
