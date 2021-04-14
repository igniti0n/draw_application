part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsChanged extends SettingsEvent {
  final Paint paint;
  const SettingsChanged(this.paint);
}

class SettingsStrokeWidthChanged extends SettingsEvent {
  final double strokeWidth;
  const SettingsStrokeWidthChanged(this.strokeWidth);
}

// class SettingsColorChanged extends SettingsEvent {
//   final Color color;
//   const SettingsColorChanged(this.color);
// }
