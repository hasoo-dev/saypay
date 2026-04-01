enum Environment { dev, staging, prod }

class AppConfig {
  static late Environment environment;
  static late String supabaseUrl;
  static late String supabaseAnonKey;

  static void initialize(Environment env) {
    environment = env;
    switch (env) {
      case Environment.dev:
        supabaseUrl = 'https://lfezgctmoguzljzfqrux.supabase.co'; // Using existing as dev for now
        supabaseAnonKey = 'sb_publishable_3w-cR_SmmjPo7v59CBZBvw_kbgj2WL6';
        break;
      case Environment.staging:
        supabaseUrl = 'https://lfezgctmoguzljzfqrux.supabase.co'; // Using existing as staging for now
        supabaseAnonKey = 'sb_publishable_3w-cR_SmmjPo7v59CBZBvw_kbgj2WL6';
        break;
      case Environment.prod:
        supabaseUrl = 'https://lfezgctmoguzljzfqrux.supabase.co'; 
        supabaseAnonKey = 'sb_publishable_3w-cR_SmmjPo7v59CBZBvw_kbgj2WL6';
        break;
    }
  }
}
