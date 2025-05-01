// providers/language_provider.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../generated/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  final String _prefsKey = 'language_code';

  // 缓存SharedPreferences实例
  static SharedPreferences? _prefsInstance;

  // 跟踪尝试次数
  int _retryCount = 0;
  final int _maxRetries = 3;
  bool _isLoading = false;

  // 获取当前语言区域
  Locale get locale => _locale;

  // 构造函数，初始化时加载保存的语言设置
  LanguageProvider() {
    _loadSavedLanguage();
  }

  // 安全获取SharedPreferences实例
  Future<SharedPreferences?> _getPrefs() async {
    // 如果已经有实例，直接返回
    if (_prefsInstance != null) {
      return _prefsInstance;
    }

    try {
      // 尝试获取新实例，带超时处理
      final prefs = await SharedPreferences.getInstance()
          .timeout(const Duration(seconds: 2), onTimeout: () {
        throw TimeoutException(S.current.getPrefsTimeout);
      });

      _prefsInstance = prefs; // 保存成功的实例
      return prefs;
    } catch (e) {
      debugPrint(S.current.getPrefsError(e.toString()));
      return null;
    }
  }

  // 从SharedPreferences加载保存的语言设置
  Future<void> _loadSavedLanguage() async {
    if (_isLoading) return;
    _isLoading = true;

    while (_retryCount < _maxRetries) {
      try {
        // 添加渐进增长的延迟
        final delay = Duration(milliseconds: 500 * (_retryCount + 1));
        await Future.delayed(delay);

        final prefs = await _getPrefs();
        if (prefs == null) {
          _retryCount++;
          continue;
        }

        final String? languageCode = prefs.getString(_prefsKey);
        if (languageCode != null) {
          _locale = Locale(languageCode);
          notifyListeners();
          debugPrint(S.current.loadLanguageSuccess(languageCode));
        }

        _isLoading = false;
        return; // 成功加载，退出函数
      } catch (e) {
        debugPrint(S.current.loadLanguageRetryFailed(_retryCount + 1, e.toString()));
        _retryCount++;
      }
    }

    debugPrint(S.current.loadLanguageMaxRetries(_maxRetries));
    _isLoading = false;
  }

  // 设置新的语言
  Future<void> setLocale(String languageCode) async {
    if (_locale.languageCode != languageCode) {
      // 立即更新语言，不等待SharedPreferences
      _locale = Locale(languageCode);
      notifyListeners();

      try {
        final prefs = await _getPrefs();
        if (prefs != null) {
          await prefs.setString(_prefsKey, languageCode);
          debugPrint(S.current.saveLanguageSuccess(languageCode));
        }
      } catch (e) {
        debugPrint(S.current.saveLanguageError(e.toString()));
        // 即使保存失败，应用也已经切换了语言
      }
    }
  }

  // 切换语言（在英文和中文之间切换）
  Future<void> toggleLanguage() async {
    final newLanguageCode = _locale.languageCode == 'en' ? 'zh' : 'en';
    await setLocale(newLanguageCode);
  }
}