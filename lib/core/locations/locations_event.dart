import 'package:flutter_base_kit/flutter_base_kit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'locations_event.freezed.dart';

@freezed
sealed class LocationsEvent extends BaseEventI with _$LocationsEvent {
  const LocationsEvent._() : super();

  const factory LocationsEvent.loadInitialRequested() = LoadInitialRequested;

  const factory LocationsEvent.loadMoreRequested() = LoadMoreRequested;

  const factory LocationsEvent.refreshRequested() = RefreshRequested;

  const factory LocationsEvent.retryRequested() = RetryRequested;
}