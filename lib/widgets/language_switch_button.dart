import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isEnglish = languageProvider.locale.languageCode == 'en';
        return IconButton(
          icon: Icon(
            isEnglish ? Icons.language : Icons.translate,
            size: 24,
          ),
          onPressed: () {
            languageProvider.toggleLanguage();
          },
          tooltip: isEnglish ? '切换到中文' : 'Switch to English',
        );
      },
    );
  }
}