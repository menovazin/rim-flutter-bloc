import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/app_error_kind.dart';
import '../../domain/entities/episode.dart';

part 'episodes_state.freezed.dart';

@freezed
abstract class EpisodesState extends BaseStateI with _$EpisodesState {
  const EpisodesState._();

  /// True while a load (initial or refresh) is in progress.
  bool get isBusy =>
      status == StateStatus.loading || status == StateStatus.refresh;

  const factory EpisodesState({
    @Default(StateStatus.initial) StateStatus status,
    @Default('') String message,
    @Default(<Episode>[]) List<Episode> items,
    @Default(1) int page,
    @Default(true) bool hasNext,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    AppErrorKind? errorKind,
  }) = _EpisodesState;
}