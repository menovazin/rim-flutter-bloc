import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episodes_event.freezed.dart';

@freezed
sealed class EpisodesEvent extends BaseEventI with _$EpisodesEvent {
  const EpisodesEvent._() : super();

  const factory EpisodesEvent.loadInitialRequested() = LoadInitialRequested;

  const factory EpisodesEvent.loadMoreRequested() = LoadMoreRequested;

  const factory EpisodesEvent.refreshRequested() = RefreshRequested;

  const factory EpisodesEvent.retryRequested() = RetryRequested;
}