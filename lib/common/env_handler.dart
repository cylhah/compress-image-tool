class EnvHandler {
  static const String runEnv =
      String.fromEnvironment('RunEnv', defaultValue: 'local');

  static bool isLocal() {
    return EnvHandler.runEnv == 'local';
  }

  static bool isDist() {
    return EnvHandler.runEnv == 'dist';
  }
}
