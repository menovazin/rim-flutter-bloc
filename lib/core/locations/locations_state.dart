import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/app_error_kind.dart';
import '../../domain/entities/location.dart';

part 'locations_state.freezed.dart';

@freezed
abstract class LocationsState extends BaseStateI with _$LocationsState {
  const LocationsState._();

  /// True while a load (initial or refresh) is in progress.
  bool get isBusy =>
      status == StateStatus.loading || status == StateStatus.refresh;

  const factory LocationsState({
    @Default(StateStatus.initial) StateStatus status,
    @Default('') String message,
    @Default(<Location>[]) List<Location> items,
    @Default(1) int page,
    @Default(true) bool hasNext,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    AppErrorKind? errorKind,
  }) = _LocationsState;
}