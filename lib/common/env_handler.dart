class EnvHandler {
  static const String RunEnv =
      String.fromEnvironment('RunEnv', defaultValue: 'local');

  static bool isLocal() {
    return EnvHandler.RunEnv == 'local';
  }

  static bool isDist() {
    return EnvHandler.RunEnv == 'dist';
  }
}
