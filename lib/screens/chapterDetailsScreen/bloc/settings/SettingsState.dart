abstract class SettingsState {
  final double fontSize;
  final bool isDarkMode;
  final bool isScrollView;

  SettingsState({required this.fontSize, required this.isDarkMode, required this.isScrollView});
}

class CurrentSettingsState extends SettingsState {
  CurrentSettingsState({required super.fontSize, required super.isDarkMode, required super.isScrollView});
}


