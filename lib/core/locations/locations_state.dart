part of 'locations_cubit.dart';

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
  }) = _LocationsState;
}
