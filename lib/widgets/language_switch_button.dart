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
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                languageProvider.toggleLanguage();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isEnglish ? Icons.language : Icons.translate,
                  color: Color(0xFF2E7CFF),
                  size: 24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}