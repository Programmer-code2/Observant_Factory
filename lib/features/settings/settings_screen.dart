import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    final locale = ref.watch(localeProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        children: [
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.language),
              title: Text(strings.language),
              subtitle: Text(locale.languageCode == 'ar' ? 'العربية' : 'English'),
              value: locale.languageCode == 'ar',
              onChanged: (_) => ref.read(localeProvider.notifier).toggle(),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(strings.about),
                  subtitle: const Text('جولات تفتيشية | Observations'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.smartphone_outlined),
                  title: Text(strings.appVersion),
                  subtitle: const Text('1.0.0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
