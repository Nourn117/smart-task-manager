// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_overview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyncOverview {

/// Whether the API was reachable on the last attempt.
 bool get isOnline; bool get isSyncing;/// Local changes waiting to be sent to the server.
 int get pendingChanges;/// Pending changes whose last upload attempt failed.
 int get failedChanges; DateTime? get lastSyncedAt; String? get lastError;
/// Create a copy of SyncOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncOverviewCopyWith<SyncOverview> get copyWith => _$SyncOverviewCopyWithImpl<SyncOverview>(this as SyncOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SyncOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncOverview&&(identical(other.isOnline, _this.isOnline) || other.isOnline == _this.isOnline)&&(identical(other.isSyncing, _this.isSyncing) || other.isSyncing == _this.isSyncing)&&(identical(other.pendingChanges, _this.pendingChanges) || other.pendingChanges == _this.pendingChanges)&&(identical(other.failedChanges, _this.failedChanges) || other.failedChanges == _this.failedChanges)&&(identical(other.lastSyncedAt, _this.lastSyncedAt) || other.lastSyncedAt == _this.lastSyncedAt)&&(identical(other.lastError, _this.lastError) || other.lastError == _this.lastError));
}


@override
int get hashCode {
  final _this = this as SyncOverview;
  return Object.hash(runtimeType,_this.isOnline,_this.isSyncing,_this.pendingChanges,_this.failedChanges,_this.lastSyncedAt,_this.lastError);
}

@override
String toString() {
  final _this = this as SyncOverview;
  return 'SyncOverview(isOnline: ${_this.isOnline}, isSyncing: ${_this.isSyncing}, pendingChanges: ${_this.pendingChanges}, failedChanges: ${_this.failedChanges}, lastSyncedAt: ${_this.lastSyncedAt}, lastError: ${_this.lastError})';
}


}

/// @nodoc
abstract mixin class $SyncOverviewCopyWith<$Res>  {
  factory $SyncOverviewCopyWith(SyncOverview value, $Res Function(SyncOverview) _then) = _$SyncOverviewCopyWithImpl;
@useResult
$Res call({
 bool isOnline, bool isSyncing, int pendingChanges, int failedChanges, DateTime? lastSyncedAt, String? lastError
});




}
/// @nodoc
class _$SyncOverviewCopyWithImpl<$Res>
    implements $SyncOverviewCopyWith<$Res> {
  _$SyncOverviewCopyWithImpl(this._self, this._then);

  final SyncOverview _self;
  final $Res Function(SyncOverview) _then;

/// Create a copy of SyncOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOnline = null,Object? isSyncing = null,Object? pendingChanges = null,Object? failedChanges = null,Object? lastSyncedAt = freezed,Object? lastError = freezed,}) {
  return _then(SyncOverview(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,pendingChanges: null == pendingChanges ? _self.pendingChanges : pendingChanges // ignore: cast_nullable_to_non_nullable
as int,failedChanges: null == failedChanges ? _self.failedChanges : failedChanges // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncOverview].
extension SyncOverviewPatterns on SyncOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncOverview() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncOverview value)  $default,){
final _that = this;
switch (_that) {
case _SyncOverview():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncOverview value)?  $default,){
final _that = this;
switch (_that) {
case _SyncOverview() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOnline,  bool isSyncing,  int pendingChanges,  int failedChanges,  DateTime? lastSyncedAt,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncOverview() when $default != null:
return $default(_that.isOnline,_that.isSyncing,_that.pendingChanges,_that.failedChanges,_that.lastSyncedAt,_that.lastError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOnline,  bool isSyncing,  int pendingChanges,  int failedChanges,  DateTime? lastSyncedAt,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _SyncOverview():
return $default(_that.isOnline,_that.isSyncing,_that.pendingChanges,_that.failedChanges,_that.lastSyncedAt,_that.lastError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOnline,  bool isSyncing,  int pendingChanges,  int failedChanges,  DateTime? lastSyncedAt,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _SyncOverview() when $default != null:
return $default(_that.isOnline,_that.isSyncing,_that.pendingChanges,_that.failedChanges,_that.lastSyncedAt,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc


class _SyncOverview implements SyncOverview {
  const _SyncOverview({this.isOnline = true, this.isSyncing = false, this.pendingChanges = 0, this.failedChanges = 0, this.lastSyncedAt, this.lastError});
  

/// Whether the API was reachable on the last attempt.
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isSyncing;
/// Local changes waiting to be sent to the server.
@override@JsonKey() final  int pendingChanges;
/// Pending changes whose last upload attempt failed.
@override@JsonKey() final  int failedChanges;
@override final  DateTime? lastSyncedAt;
@override final  String? lastError;

/// Create a copy of SyncOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncOverviewCopyWith<_SyncOverview> get copyWith => __$SyncOverviewCopyWithImpl<_SyncOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncOverview&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isSyncing, isSyncing) || other.isSyncing == isSyncing)&&(identical(other.pendingChanges, pendingChanges) || other.pendingChanges == pendingChanges)&&(identical(other.failedChanges, failedChanges) || other.failedChanges == failedChanges)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isOnline,isSyncing,pendingChanges,failedChanges,lastSyncedAt,lastError);
}

@override
String toString() {
    return 'SyncOverview(isOnline: $isOnline, isSyncing: $isSyncing, pendingChanges: $pendingChanges, failedChanges: $failedChanges, lastSyncedAt: $lastSyncedAt, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$SyncOverviewCopyWith<$Res> implements $SyncOverviewCopyWith<$Res> {
  factory _$SyncOverviewCopyWith(_SyncOverview value, $Res Function(_SyncOverview) _then) = __$SyncOverviewCopyWithImpl;
@override @useResult
$Res call({
 bool isOnline, bool isSyncing, int pendingChanges, int failedChanges, DateTime? lastSyncedAt, String? lastError
});




}
/// @nodoc
class __$SyncOverviewCopyWithImpl<$Res>
    implements _$SyncOverviewCopyWith<$Res> {
  __$SyncOverviewCopyWithImpl(this._self, this._then);

  final _SyncOverview _self;
  final $Res Function(_SyncOverview) _then;

/// Create a copy of SyncOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOnline = null,Object? isSyncing = null,Object? pendingChanges = null,Object? failedChanges = null,Object? lastSyncedAt = freezed,Object? lastError = freezed,}) {
  return _then(_SyncOverview(
isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isSyncing: null == isSyncing ? _self.isSyncing : isSyncing // ignore: cast_nullable_to_non_nullable
as bool,pendingChanges: null == pendingChanges ? _self.pendingChanges : pendingChanges // ignore: cast_nullable_to_non_nullable
as int,failedChanges: null == failedChanges ? _self.failedChanges : failedChanges // ignore: cast_nullable_to_non_nullable
as int,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
