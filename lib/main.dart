import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:saypay/app/spendly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:saypay/core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize configuration
  AppConfig.initialize();

  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  // runApp(const Spendly());
  runApp(DevicePreview(builder: (context) => Spendly()));
}
