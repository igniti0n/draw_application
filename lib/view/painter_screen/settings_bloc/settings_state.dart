part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState(this.paintSettings);
  final Paint paintSettings;
  @override
  List<Object> get props => [paintSettings];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(Paint paintSettings) : super(paintSettings);
}

class SettingsLoading extends SettingsState {
  const SettingsLoading(Paint paintSettings) : super(paintSettings);
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(Paint paintSettings) : super(paintSettings);
}
