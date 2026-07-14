// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locations_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationsState {
  StateStatus get status;
  String get message;
  List<Location> get items;
  int get page;
  bool get hasNext;
  bool get isLoadingMore;
  bool get hasError;
  AppErrorKind? get errorKind;

  /// Create a copy of LocationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationsStateCopyWith<LocationsState> get copyWith =>
      _$LocationsStateCopyWithImpl<LocationsState>(
          this as LocationsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationsState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorKind, errorKind) ||
                other.errorKind == errorKind));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      message,
      const DeepCollectionEquality().hash(items),
      page,
      hasNext,
      isLoadingMore,
      hasError,
      errorKind);

  @override
  String toString() {
    return 'LocationsState(status: $status, message: $message, items: $items, page: $page, hasNext: $hasNext, isLoadingMore: $isLoadingMore, hasError: $hasError, errorKind: $errorKind)';
  }
}

/// @nodoc
abstract mixin class $LocationsStateCopyWith<$Res> {
  factory $LocationsStateCopyWith(
          LocationsState value, $Res Function(LocationsState) _then) =
      _$LocationsStateCopyWithImpl;
  @useResult
  $Res call(
      {StateStatus status,
      String message,
      List<Location> items,
      int page,
      bool hasNext,
      bool isLoadingMore,
      bool hasError,
      AppErrorKind? errorKind});
}

/// @nodoc
class _$LocationsStateCopyWithImpl<$Res>
    implements $LocationsStateCopyWith<$Res> {
  _$LocationsStateCopyWithImpl(this._self, this._then);

  final LocationsState _self;
  final $Res Function(LocationsState) _then;

  /// Create a copy of LocationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? items = null,
    Object? page = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? hasError = null,
    Object? errorKind = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _self.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorKind: freezed == errorKind
          ? _self.errorKind
          : errorKind // ignore: cast_nullable_to_non_nullable
              as AppErrorKind?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocationsState].
extension LocationsStatePatterns on LocationsState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LocationsState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationsState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_LocationsState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationsState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LocationsState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationsState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            StateStatus status,
            String message,
            List<Location> items,
            int page,
            bool hasNext,
            bool isLoadingMore,
            bool hasError,
            AppErrorKind? errorKind)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationsState() when $default != null:
        return $default(
            _that.status,
            _that.message,
            _that.items,
            _that.page,
            _that.hasNext,
            _that.isLoadingMore,
            _that.hasError,
            _that.errorKind);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            StateStatus status,
            String message,
            List<Location> items,
            int page,
            bool hasNext,
            bool isLoadingMore,
            bool hasError,
            AppErrorKind? errorKind)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationsState():
        return $default(
            _that.status,
            _that.message,
            _that.items,
            _that.page,
            _that.hasNext,
            _that.isLoadingMore,
            _that.hasError,
            _that.errorKind);
      case _:
        throw StateError('Unexpected subclass');
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            StateStatus status,
            String message,
            List<Location> items,
            int page,
            bool hasNext,
            bool isLoadingMore,
            bool hasError,
            AppErrorKind? errorKind)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationsState() when $default != null:
        return $default(
            _that.status,
            _that.message,
            _that.items,
            _that.page,
            _that.hasNext,
            _that.isLoadingMore,
            _that.hasError,
            _that.errorKind);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LocationsState extends LocationsState {
  const _LocationsState(
      {this.status = StateStatus.initial,
      this.message = '',
      final List<Location> items = const <Location>[],
      this.page = 1,
      this.hasNext = true,
      this.isLoadingMore = false,
      this.hasError = false,
      this.errorKind})
      : _items = items,
        super._();

  @override
  @JsonKey()
  final StateStatus status;
  @override
  @JsonKey()
  final String message;
  final List<Location> _items;
  @override
  @JsonKey()
  List<Location> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasError;
  @override
  final AppErrorKind? errorKind;

  /// Create a copy of LocationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationsStateCopyWith<_LocationsState> get copyWith =>
      __$LocationsStateCopyWithImpl<_LocationsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationsState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorKind, errorKind) ||
                other.errorKind == errorKind));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      message,
      const DeepCollectionEquality().hash(_items),
      page,
      hasNext,
      isLoadingMore,
      hasError,
      errorKind);

  @override
  String toString() {
    return 'LocationsState(status: $status, message: $message, items: $items, page: $page, hasNext: $hasNext, isLoadingMore: $isLoadingMore, hasError: $hasError, errorKind: $errorKind)';
  }
}

/// @nodoc
abstract mixin class _$LocationsStateCopyWith<$Res>
    implements $LocationsStateCopyWith<$Res> {
  factory _$LocationsStateCopyWith(
          _LocationsState value, $Res Function(_LocationsState) _then) =
      __$LocationsStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {StateStatus status,
      String message,
      List<Location> items,
      int page,
      bool hasNext,
      bool isLoadingMore,
      bool hasError,
      AppErrorKind? errorKind});
}

/// @nodoc
class __$LocationsStateCopyWithImpl<$Res>
    implements _$LocationsStateCopyWith<$Res> {
  __$LocationsStateCopyWithImpl(this._self, this._then);

  final _LocationsState _self;
  final $Res Function(_LocationsState) _then;

  /// Create a copy of LocationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? items = null,
    Object? page = null,
    Object? hasNext = null,
    Object? isLoadingMore = null,
    Object? hasError = null,
    Object? errorKind = freezed,
  }) {
    return _then(_LocationsState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Location>,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _self.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorKind: freezed == errorKind
          ? _self.errorKind
          : errorKind // ignore: cast_nullable_to_non_nullable
              as AppErrorKind?,
    ));
  }
}

// dart format on
