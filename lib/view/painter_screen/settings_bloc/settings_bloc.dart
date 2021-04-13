import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

final Paint DEFAULT_PAINT = Paint()
  ..color = Colors.black
  ..strokeWidth = 2;

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  Paint _currentPaint = DEFAULT_PAINT;
  SettingsBloc() : super(SettingsInitial(DEFAULT_PAINT));

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    //log("SETTINGS event:" + event.toString());
    if (event is SettingsChanged) {
      yield SettingsLoading(event.paint);
      _currentPaint = event.paint;
      yield SettingsLoaded(event.paint);
    } else if (event is SettingsStrokeWidthChanged) {
      _currentPaint..strokeWidth = event.strokeWidth;
      yield SettingsLoading(_currentPaint);
      yield SettingsLoaded(_currentPaint);
    } else if (event is SettingsColorChanged) {
      _currentPaint..color = event.color;
      yield SettingsLoading(_currentPaint);
      yield SettingsLoaded(_currentPaint);
    }
  }
}
