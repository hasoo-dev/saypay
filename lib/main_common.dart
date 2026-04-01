import 'package:flutter/material.dart';
import 'package:saypay/app/spendly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:saypay/core/config/app_config.dart';

void mainCommon(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize configuration
  AppConfig.initialize(env);

  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  runApp(const Spendly());
}
