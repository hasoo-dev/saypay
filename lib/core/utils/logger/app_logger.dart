// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class AppLogger {
  // ANSI Color Codes for Terminal Output
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';

  static void info(String message, {String? tag}) {
    _log('${_blue}[INFO]${_reset} ${tag != null ? '[$tag] ' : ''}$message');
  }

  static void success(String message, {String? tag}) {
    _log('${_green}[SUCCESS]${_reset} ${tag != null ? '[$tag] ' : ''}$message');
  }

  static void warning(String message, {String? tag}) {
    _log('${_yellow}[WARNING]${_reset} ${tag != null ? '[$tag] ' : ''}$message');
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace, String? tag}) {
    _log('${_red}[ERROR]${_reset} ${tag != null ? '[$tag] ' : ''}$message');
    if (error != null) _log('${_red}Details:${_reset} $error');
    if (stackTrace != null) developer.log('Stack Trace', stackTrace: stackTrace);
  }

  static void debug(String message, {String? tag}) {
    _log('${_cyan}[DEBUG]${_reset} ${tag != null ? '[$tag] ' : ''}$message');
  }

  static void auth(String message) {
    _log('${_magenta}[AUTH]${_reset} $message');
  }

  static void _log(String message) {
    // developer.log is better for large strings and doesn't clutter production as much
    developer.log(message, name: 'Spendly');
    // Also print to console during development for immediate feedback
    debugPrint(message); 
  }
}
