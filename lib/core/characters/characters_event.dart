import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'characters_event.freezed.dart';

@freezed
sealed class CharactersEvent extends BaseEventI with _$CharactersEvent {
  const CharactersEvent._() : super();

  const factory CharactersEvent.loadInitialRequested() = LoadInitialRequested;

  const factory CharactersEvent.loadMoreRequested() = LoadMoreRequested;

  const factory CharactersEvent.refreshRequested() = RefreshRequested;

  const factory CharactersEvent.retryRequested() = RetryRequested;
}