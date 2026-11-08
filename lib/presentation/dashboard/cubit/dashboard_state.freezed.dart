// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 TaskSummary? get summary;/// The status picked from the summary cards; filters [recentTasks].
 TaskStatusFilter get selectedStatus; List<Task>? get recentTasks; String? get errorMessage;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DashboardState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&(identical(other.selectedStatus, _this.selectedStatus) || other.selectedStatus == _this.selectedStatus)&&const DeepCollectionEquality().equals(other.recentTasks, _this.recentTasks)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as DashboardState;
  return Object.hash(runtimeType,_this.summary,_this.selectedStatus,const DeepCollectionEquality().hash(_this.recentTasks),_this.errorMessage);
}

@override
String toString() {
  final _this = this as DashboardState;
  return 'DashboardState(summary: ${_this.summary}, selectedStatus: ${_this.selectedStatus}, recentTasks: ${_this.recentTasks}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 TaskSummary? summary, TaskStatusFilter selectedStatus, List<Task>? recentTasks, String? errorMessage
});


$TaskSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,Object? selectedStatus = null,Object? recentTasks = freezed,Object? errorMessage = freezed,}) {
  return _then(DashboardState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TaskSummary?,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,recentTasks: freezed == recentTasks ? _self.recentTasks : recentTasks // ignore: cast_nullable_to_non_nullable
as List<Task>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $TaskSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TaskSummary? summary,  TaskStatusFilter selectedStatus,  List<Task>? recentTasks,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.summary,_that.selectedStatus,_that.recentTasks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TaskSummary? summary,  TaskStatusFilter selectedStatus,  List<Task>? recentTasks,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.summary,_that.selectedStatus,_that.recentTasks,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TaskSummary? summary,  TaskStatusFilter selectedStatus,  List<Task>? recentTasks,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.summary,_that.selectedStatus,_that.recentTasks,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState extends DashboardState {
  const _DashboardState({this.summary, this.selectedStatus = TaskStatusFilter.all,  List<Task>? recentTasks, this.errorMessage}): _recentTasks = recentTasks,super._();
  

@override final  TaskSummary? summary;
/// The status picked from the summary cards; filters [recentTasks].
@override@JsonKey() final  TaskStatusFilter selectedStatus;
 final  List<Task>? _recentTasks;
@override List<Task>? get recentTasks {
  final value = _recentTasks;
  if (value == null) return null;
  if (_recentTasks is EqualUnmodifiableListView) return _recentTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? errorMessage;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&const DeepCollectionEquality().equals(other.recentTasks, _recentTasks)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary,selectedStatus,const DeepCollectionEquality().hash(_recentTasks),errorMessage);
}

@override
String toString() {
    return 'DashboardState(summary: $summary, selectedStatus: $selectedStatus, recentTasks: $recentTasks, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 TaskSummary? summary, TaskStatusFilter selectedStatus, List<Task>? recentTasks, String? errorMessage
});


@override $TaskSummaryCopyWith<$Res>? get summary;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,Object? selectedStatus = null,Object? recentTasks = freezed,Object? errorMessage = freezed,}) {
  return _then(_DashboardState(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TaskSummary?,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,recentTasks: freezed == recentTasks ? _self._recentTasks : recentTasks // ignore: cast_nullable_to_non_nullable
as List<Task>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskSummaryCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $TaskSummaryCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
