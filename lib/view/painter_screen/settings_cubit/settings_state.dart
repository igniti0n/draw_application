part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState(this.paintSettings);
  final PaintSettings paintSettings;

  @override
  List<Object> get props => [this.paintSettings];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial()
      : super(const PaintSettings(drawColor: Colors.black, strokeWidth: 2));
}

class SettingsChanged extends SettingsState {
  const SettingsChanged(PaintSettings paintSettings) : super(paintSettings);
}
