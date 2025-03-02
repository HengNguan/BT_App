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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `==================== Language Provider ==================== `
  String get language_provider {
    return Intl.message(
      '==================== Language Provider ==================== ',
      name: 'language_provider',
      desc: '',
      args: [],
    );
  }

  /// `Successfully loaded language setting: {languageCode}`
  String loadLanguageSuccess(String languageCode) {
    return Intl.message(
      'Successfully loaded language setting: $languageCode',
      name: 'loadLanguageSuccess',
      desc: 'Message shown when language setting is successfully loaded',
      args: [languageCode],
    );
  }

  /// `Language setting load attempt {attempt} failed: {error}`
  String loadLanguageRetryFailed(int attempt, String error) {
    return Intl.message(
      'Language setting load attempt $attempt failed: $error',
      name: 'loadLanguageRetryFailed',
      desc: 'Message shown when a language setting load attempt fails',
      args: [attempt, error],
    );
  }

  /// `Unable to load language settings after {maxRetries} attempts, using default language`
  String loadLanguageMaxRetries(int maxRetries) {
    return Intl.message(
      'Unable to load language settings after $maxRetries attempts, using default language',
      name: 'loadLanguageMaxRetries',
      desc: 'Message shown when maximum retry attempts are reached',
      args: [maxRetries],
    );
  }

  /// `SharedPreferences initialization timeout`
  String get getPrefsTimeout {
    return Intl.message(
      'SharedPreferences initialization timeout',
      name: 'getPrefsTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get SharedPreferences: {error}`
  String getPrefsError(String error) {
    return Intl.message(
      'Failed to get SharedPreferences: $error',
      name: 'getPrefsError',
      desc: 'Message shown when SharedPreferences access fails',
      args: [error],
    );
  }

  /// `Language setting saved: {languageCode}`
  String saveLanguageSuccess(String languageCode) {
    return Intl.message(
      'Language setting saved: $languageCode',
      name: 'saveLanguageSuccess',
      desc: 'Message shown when language setting is successfully saved',
      args: [languageCode],
    );
  }

  /// `Failed to save language setting: {error}`
  String saveLanguageError(String error) {
    return Intl.message(
      'Failed to save language setting: $error',
      name: 'saveLanguageError',
      desc: 'Message shown when saving language setting fails',
      args: [error],
    );
  }

  /// `==================== Permission Denied page ==================== `
  String get permission_denied_page {
    return Intl.message(
      '==================== Permission Denied page ==================== ',
      name: 'permission_denied_page',
      desc: '',
      args: [],
    );
  }

  /// `Permissions Needed`
  String get permissionNeeded {
    return Intl.message(
      'Permissions Needed',
      name: 'permissionNeeded',
      desc: '',
      args: [],
    );
  }

  /// `Oops! It looks like some necessary permissions are missing. Please enable them in settings to continue using the app.`
  String get permissionDenied {
    return Intl.message(
      'Oops! It looks like some necessary permissions are missing. Please enable them in settings to continue using the app.',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
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

  /// `Successfully Connected`
  String get successfulConnect {
    return Intl.message(
      'Successfully Connected',
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

  /// `Scanning...`
  String get scanning {
    return Intl.message('Scanning...', name: 'scanning', desc: '', args: []);
  }

  /// `Scan for Devices`
  String get scanForDevices {
    return Intl.message(
      'Scan for Devices',
      name: 'scanForDevices',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Device`
  String get unknownDevice {
    return Intl.message(
      'Unknown Device',
      name: 'unknownDevice',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get deviceId {
    return Intl.message('ID', name: 'deviceId', desc: '', args: []);
  }

  /// `Connect`
  String get connect {
    return Intl.message('Connect', name: 'connect', desc: '', args: []);
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message('Disconnect', name: 'disconnect', desc: '', args: []);
  }

  /// `Battery`
  String get battery {
    return Intl.message('Battery', name: 'battery', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Serial`
  String get serial {
    return Intl.message('Serial', name: 'serial', desc: '', args: []);
  }

  /// `Power`
  String get power {
    return Intl.message('Power', name: 'power', desc: '', args: []);
  }

  /// `On`
  String get on {
    return Intl.message('On', name: 'on', desc: '', args: []);
  }

  /// `Time to drink water • now`
  String get timeToDrinkWater {
    return Intl.message(
      'Time to drink water • now',
      name: 'timeToDrinkWater',
      desc: '',
      args: [],
    );
  }

  /// `Stay hydrated by drinking water!`
  String get stayHydrated {
    return Intl.message(
      'Stay hydrated by drinking water!',
      name: 'stayHydrated',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get availableDevices {
    return Intl.message(
      'Available',
      name: 'availableDevices',
      desc: '',
      args: [],
    );
  }

  /// `Connected Device`
  String get connectedDevice {
    return Intl.message(
      'Connected Device',
      name: 'connectedDevice',
      desc: '',
      args: [],
    );
  }

  /// `Device Info`
  String get deviceInfo {
    return Intl.message('Device Info', name: 'deviceInfo', desc: '', args: []);
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
    return Intl.message('Overview', name: 'overview', desc: '', args: []);
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
    return Intl.message('Drink Log', name: 'drinkLog', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
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
