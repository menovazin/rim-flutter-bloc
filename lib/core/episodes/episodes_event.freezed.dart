// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episodes_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EpisodesEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EpisodesEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent()';
  }
}

/// @nodoc
class $EpisodesEventCopyWith<$Res> {
  $EpisodesEventCopyWith(EpisodesEvent _, $Res Function(EpisodesEvent) __);
}

/// Adds pattern-matching-related methods to [EpisodesEvent].
extension EpisodesEventPatterns on EpisodesEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadInitialRequested value)? loadInitialRequested,
    TResult Function(LoadMoreRequested value)? loadMoreRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(RetryRequested value)? retryRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested() when loadInitialRequested != null:
        return loadInitialRequested(_that);
      case LoadMoreRequested() when loadMoreRequested != null:
        return loadMoreRequested(_that);
      case RefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
      case RetryRequested() when retryRequested != null:
        return retryRequested(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadInitialRequested value) loadInitialRequested,
    required TResult Function(LoadMoreRequested value) loadMoreRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(RetryRequested value) retryRequested,
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested():
        return loadInitialRequested(_that);
      case LoadMoreRequested():
        return loadMoreRequested(_that);
      case RefreshRequested():
        return refreshRequested(_that);
      case RetryRequested():
        return retryRequested(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadInitialRequested value)? loadInitialRequested,
    TResult? Function(LoadMoreRequested value)? loadMoreRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(RetryRequested value)? retryRequested,
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested() when loadInitialRequested != null:
        return loadInitialRequested(_that);
      case LoadMoreRequested() when loadMoreRequested != null:
        return loadMoreRequested(_that);
      case RefreshRequested() when refreshRequested != null:
        return refreshRequested(_that);
      case RetryRequested() when retryRequested != null:
        return retryRequested(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadInitialRequested,
    TResult Function()? loadMoreRequested,
    TResult Function()? refreshRequested,
    TResult Function()? retryRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested() when loadInitialRequested != null:
        return loadInitialRequested();
      case LoadMoreRequested() when loadMoreRequested != null:
        return loadMoreRequested();
      case RefreshRequested() when refreshRequested != null:
        return refreshRequested();
      case RetryRequested() when retryRequested != null:
        return retryRequested();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadInitialRequested,
    required TResult Function() loadMoreRequested,
    required TResult Function() refreshRequested,
    required TResult Function() retryRequested,
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested():
        return loadInitialRequested();
      case LoadMoreRequested():
        return loadMoreRequested();
      case RefreshRequested():
        return refreshRequested();
      case RetryRequested():
        return retryRequested();
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadInitialRequested,
    TResult? Function()? loadMoreRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? retryRequested,
  }) {
    final _that = this;
    switch (_that) {
      case LoadInitialRequested() when loadInitialRequested != null:
        return loadInitialRequested();
      case LoadMoreRequested() when loadMoreRequested != null:
        return loadMoreRequested();
      case RefreshRequested() when refreshRequested != null:
        return refreshRequested();
      case RetryRequested() when retryRequested != null:
        return retryRequested();
      case _:
        return null;
    }
  }
}

/// @nodoc

class LoadInitialRequested extends EpisodesEvent {
  const LoadInitialRequested() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadInitialRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent.loadInitialRequested()';
  }
}

/// @nodoc

class LoadMoreRequested extends EpisodesEvent {
  const LoadMoreRequested() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LoadMoreRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent.loadMoreRequested()';
  }
}

/// @nodoc

class RefreshRequested extends EpisodesEvent {
  const RefreshRequested() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RefreshRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent.refreshRequested()';
  }
}

/// @nodoc

class RetryRequested extends EpisodesEvent {
  const RetryRequested() : super._();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RetryRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EpisodesEvent.retryRequested()';
  }
}

// dart format on
