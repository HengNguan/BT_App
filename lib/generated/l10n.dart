// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `==================== Home page ==================== `
  String get home_page {
    return Intl.message(
      '==================== Home page ==================== ',
      name: 'home_page',
      desc: '',
      args: [],
    );
  }

  /// `Home Tab Content`
  String get homeTabContent {
    return Intl.message(
      'Home Tab Content',
      name: 'homeTabContent',
      desc: '',
      args: [],
    );
  }

  /// `==================== Default page ==================== `
  String get default_page {
    return Intl.message(
      '==================== Default page ==================== ',
      name: 'default_page',
      desc: '',
      args: [],
    );
  }

  /// `Today's Progress`
  String get todayProgress {
    return Intl.message(
      'Today\'s Progress',
      name: 'todayProgress',
      desc: '',
      args: [],
    );
  }

  /// `Next reminder in {countdown} hours`
  String nextReminder(double countdown) {
    return Intl.message(
      'Next reminder in $countdown hours',
      name: 'nextReminder',
      desc: 'The text that shows the next reminder time',
      args: [countdown],
    );
  }

  /// `==================== Bluetooth Home page ==================== `
  String get bluetooth_home_page {
    return Intl.message(
      '==================== Bluetooth Home page ==================== ',
      name: 'bluetooth_home_page',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth not supported by this device`
  String get notSupportThisDevice {
    return Intl.message(
      'Bluetooth not supported by this device',
      name: 'notSupportThisDevice',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth is ON`
  String get bluetoothIsOn {
    return Intl.message(
      'Bluetooth is ON',
      name: 'bluetoothIsOn',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth is OFF or unavailable`
  String get bluetoothIsOff {
    return Intl.message(
      'Bluetooth is OFF or unavailable',
      name: 'bluetoothIsOff',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on Bluetooth`
  String get turnOnBluetooth {
    return Intl.message(
      'Please turn on Bluetooth',
      name: 'turnOnBluetooth',
      desc: '',
      args: [],
    );
  }

  /// `Connecting...`
  String get connecting {
    return Intl.message(
      'Connecting...',
      name: 'connecting',
      desc: '',
      args: [],
    );
  }

  /// `Successful Connect`
  String get successfulConnect {
    return Intl.message(
      'Successful Connect',
      name: 'successfulConnect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get disconnected {
    return Intl.message(
      'Disconnected',
      name: 'disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Bluetooth Scanner`
  String get bluetoothScanner {
    return Intl.message(
      'Bluetooth Scanner',
      name: 'bluetoothScanner',
      desc: '',
      args: [],
    );
  }

  /// `Data Packets Received:`
  String get dataPacketReceived {
    return Intl.message(
      'Data Packets Received:',
      name: 'dataPacketReceived',
      desc: '',
      args: [],
    );
  }

  /// `Parsed Data`
  String get parsedData {
    return Intl.message(
      'Parsed Data',
      name: 'parsedData',
      desc: '',
      args: [],
    );
  }

  /// `==================== Calendar page ==================== `
  String get calendar_page {
    return Intl.message(
      '==================== Calendar page ==================== ',
      name: 'calendar_page',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Progress / Goal`
  String get progressGoal {
    return Intl.message(
      'Progress / Goal',
      name: 'progressGoal',
      desc: '',
      args: [],
    );
  }

  /// `% Of Goal Achieve`
  String get percentGoal {
    return Intl.message(
      '% Of Goal Achieve',
      name: 'percentGoal',
      desc: '',
      args: [],
    );
  }

  /// `Drink Log`
  String get drinkLog {
    return Intl.message(
      'Drink Log',
      name: 'drinkLog',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
