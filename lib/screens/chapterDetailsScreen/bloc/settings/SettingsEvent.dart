abstract class SettingsEvent {}

class ChangeSettingsEvent extends SettingsEvent {
  final double? fontSize;
  final bool? isDarkMode;
  final bool? isScrollView;

  ChangeSettingsEvent({this.fontSize, this.isDarkMode, this.isScrollView});
}