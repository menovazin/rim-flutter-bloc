part of 'characters_cubit.dart';

@freezed
abstract class CharactersState extends BaseStateI with _$CharactersState {
  const CharactersState._();

  /// True while a load (initial or refresh) is in progress.
  bool get isBusy =>
      status == StateStatus.loading || status == StateStatus.refresh;

  const factory CharactersState({

    @Default(StateStatus.initial) StateStatus status,
    @Default('') String message,
    @Default(<Character>[]) List<Character> items,
    @Default(1) int page,
    @Default(true) bool hasNext,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    AppErrorKind? errorKind,
  }) = _CharactersState;
}
