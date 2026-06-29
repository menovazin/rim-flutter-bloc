part of 'episodes_cubit.dart';

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
  }) = _EpisodesState;
}
