import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paint_app/domain/entities/settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  late PaintSettings _paintSettings;

  SettingsCubit() : super(SettingsInitial()) {
    PaintSettings(drawColor: Colors.black, strokeWidth: 2);
  }

  Stream<SettingsState> get settingsStream => this.stream;

  void changeSettings(PaintSettings newSettings) {
    _paintSettings = newSettings;
    emit(SettingsChanged(_paintSettings));
  }
}
