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

  /// `Calibration`
  String get calibration {
    return Intl.message(
      'Calibration',
      name: 'calibration',
      desc: '',
      args: [],
    );
  }

  /// `Calibration History`
  String get calibrationHistory {
    return Intl.message(
      'Calibration History',
      name: 'calibrationHistory',
      desc: '',
      args: [],
    );
  }

  /// `Use this value to calibrate the device:`
  String get enterCalibrationValue {
    return Intl.message(
      'Use this value to calibrate the device:',
      name: 'enterCalibrationValue',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to calibrate your device?`
  String get doCalibration {
    return Intl.message(
      'Do you want to calibrate your device?',
      name: 'doCalibration',
      desc: '',
      args: [],
    );
  }

  /// `Enter weight value`
  String get calibrationValueHint {
    return Intl.message(
      'Enter weight value',
      name: 'calibrationValueHint',
      desc: '',
      args: [],
    );
  }

  /// `Use Current Value`
  String get useCurrentValue {
    return Intl.message(
      'Use Current Value',
      name: 'useCurrentValue',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Calibration saved successfully`
  String get calibrationSaved {
    return Intl.message(
      'Calibration saved successfully',
      name: 'calibrationSaved',
      desc: '',
      args: [],
    );
  }

  /// `Calibration deleted`
  String get calibrationDeleted {
    return Intl.message(
      'Calibration deleted',
      name: 'calibrationDeleted',
      desc: '',
      args: [],
    );
  }

  /// `No calibration history found`
  String get noCalibrationHistory {
    return Intl.message(
      'No calibration history found',
      name: 'noCalibrationHistory',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Scanning...`
  String get scanning {
    return Intl.message(
      'Scanning...',
      name: 'scanning',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'ID',
      name: 'deviceId',
      desc: '',
      args: [],
    );
  }

  /// `Connect`
  String get connect {
    return Intl.message(
      'Connect',
      name: 'connect',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Battery`
  String get battery {
    return Intl.message(
      'Battery',
      name: 'battery',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Serial`
  String get serial {
    return Intl.message(
      'Serial',
      name: 'serial',
      desc: '',
      args: [],
    );
  }

  /// `Power`
  String get power {
    return Intl.message(
      'Power',
      name: 'power',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get on {
    return Intl.message(
      'On',
      name: 'on',
      desc: '',
      args: [],
    );
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

  /// `ml`
  String get unit {
    return Intl.message(
      'ml',
      name: 'unit',
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
    return Intl.message(
      'Device Info',
      name: 'deviceInfo',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this calibration record?`
  String get confirmDeleteCalibration {
    return Intl.message(
      'Are you sure you want to delete this calibration record?',
      name: 'confirmDeleteCalibration',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `==================== Guide Dialog ==================== `
  String get guide_dialog {
    return Intl.message(
      '==================== Guide Dialog ==================== ',
      name: 'guide_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Device Guide`
  String get deviceGuide {
    return Intl.message(
      'Device Guide',
      name: 'deviceGuide',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to {deviceName}`
  String welcomeToDevice(String deviceName) {
    return Intl.message(
      'Welcome to $deviceName',
      name: 'welcomeToDevice',
      desc: 'Welcome message with device name',
      args: [deviceName],
    );
  }

  /// `This is your first time connecting to this device. Please follow these steps:`
  String get firstTimeConnectionInstructions {
    return Intl.message(
      'This is your first time connecting to this device. Please follow these steps:',
      name: 'firstTimeConnectionInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Wait for the device to send the first data packet`
  String get waitForFirstDataPacket {
    return Intl.message(
      'Wait for the device to send the first data packet',
      name: 'waitForFirstDataPacket',
      desc: '',
      args: [],
    );
  }

  /// `After receiving data, perform tare calibration`
  String get calibrateAfterDataReceived {
    return Intl.message(
      'After receiving data, perform tare calibration',
      name: 'calibrateAfterDataReceived',
      desc: '',
      args: [],
    );
  }

  /// `After calibration, weight data will be more accurate`
  String get weightDataMoreAccurate {
    return Intl.message(
      'After calibration, weight data will be more accurate',
      name: 'weightDataMoreAccurate',
      desc: '',
      args: [],
    );
  }

  /// `Note: Tare calibration is an important step to ensure weight data accuracy.`
  String get calibrationImportanceNote {
    return Intl.message(
      'Note: Tare calibration is an important step to ensure weight data accuracy.',
      name: 'calibrationImportanceNote',
      desc: '',
      args: [],
    );
  }

  /// `Calibrate Later`
  String get calibrateLater {
    return Intl.message(
      'Calibrate Later',
      name: 'calibrateLater',
      desc: '',
      args: [],
    );
  }

  /// `Calibrate Now`
  String get calibrateNow {
    return Intl.message(
      'Calibrate Now',
      name: 'calibrateNow',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get confirm {
    return Intl.message(
      'Okay',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Tip: After calibration, the system will automatically subtract this calibration value from the measurement to get an accurate net weight.`
  String get calibrationTip {
    return Intl.message(
      'Tip: After calibration, the system will automatically subtract this calibration value from the measurement to get an accurate net weight.',
      name: 'calibrationTip',
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

  /// `==================== Login page ==================== `
  String get login_page {
    return Intl.message(
      '==================== Login page ==================== ',
      name: 'login_page',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please check your username and password.`
  String get loginFailed {
    return Intl.message(
      'Login failed. Please check your username and password.',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, {displayName}!`
  String welcomeUser(String displayName) {
    return Intl.message(
      'Welcome, $displayName!',
      name: 'welcomeUser',
      desc: 'Welcome message with user\'s display name',
      args: [displayName],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Device bound to your account`
  String get deviceBound {
    return Intl.message(
      'Device bound to your account',
      name: 'deviceBound',
      desc: '',
      args: [],
    );
  }

  /// `No device bound to your account`
  String get deviceNotBound {
    return Intl.message(
      'No device bound to your account',
      name: 'deviceNotBound',
      desc: '',
      args: [],
    );
  }

  /// `Bind Device`
  String get bindDevice {
    return Intl.message(
      'Bind Device',
      name: 'bindDevice',
      desc: '',
      args: [],
    );
  }

  /// `Unbind Device`
  String get unbindDevice {
    return Intl.message(
      'Unbind Device',
      name: 'unbindDevice',
      desc: '',
      args: [],
    );
  }

  /// `This device is already bound to another user`
  String get deviceAlreadyBound {
    return Intl.message(
      'This device is already bound to another user',
      name: 'deviceAlreadyBound',
      desc: '',
      args: [],
    );
  }

  /// `Device successfully bound to your account`
  String get bindDeviceSuccess {
    return Intl.message(
      'Device successfully bound to your account',
      name: 'bindDeviceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to bind device to your account`
  String get bindDeviceFailed {
    return Intl.message(
      'Failed to bind device to your account',
      name: 'bindDeviceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Device successfully unbound from your account`
  String get unbindDeviceSuccess {
    return Intl.message(
      'Device successfully unbound from your account',
      name: 'unbindDeviceSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to unbind device from your account`
  String get unbindDeviceFailed {
    return Intl.message(
      'Failed to unbind device from your account',
      name: 'unbindDeviceFailed',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to unbind this device?`
  String get confirmUnbindDevice {
    return Intl.message(
      'Are you sure you want to unbind this device?',
      name: 'confirmUnbindDevice',
      desc: '',
      args: [],
    );
  }

  /// `Do you also want to delete the calibration data for this device?`
  String get confirmDeleteCalibrationData {
    return Intl.message(
      'Do you also want to delete the calibration data for this device?',
      name: 'confirmDeleteCalibrationData',
      desc: '',
      args: [],
    );
  }

  /// `Allow Multiple Device Binding`
  String get multiDeviceBindingTitle {
    return Intl.message(
      'Allow Multiple Device Binding',
      name: 'multiDeviceBindingTitle',
      desc: '',
      args: [],
    );
  }

  /// `When enabled, one account can bind multiple devices`
  String get multiDeviceBindingSubtitle {
    return Intl.message(
      'When enabled, one account can bind multiple devices',
      name: 'multiDeviceBindingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Allow Multiple Device Calibration`
  String get multiDeviceCalibrationTitle {
    return Intl.message(
      'Allow Multiple Device Calibration',
      name: 'multiDeviceCalibrationTitle',
      desc: '',
      args: [],
    );
  }

  /// `When enabled, one account can calibrate multiple devices`
  String get multiDeviceCalibrationSubtitle {
    return Intl.message(
      'When enabled, one account can calibrate multiple devices',
      name: 'multiDeviceCalibrationSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings updated successfully`
  String get settingsUpdated {
    return Intl.message(
      'Settings updated successfully',
      name: 'settingsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Not logged in`
  String get notLoggedIn {
    return Intl.message(
      'Not logged in',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get profile {
    return Intl.message(
      'Me',
      name: 'profile',
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
