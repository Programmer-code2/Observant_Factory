import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'l10n.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => const Locale('ar');

  void toggle() {
    state = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeProvider);
  return AppStrings(locale.languageCode == 'ar');
});
