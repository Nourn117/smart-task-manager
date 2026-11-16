// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskSummary {

 int get total; int get completed;
/// Create a copy of TaskSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSummaryCopyWith<TaskSummary> get copyWith => _$TaskSummaryCopyWithImpl<TaskSummary>(this as TaskSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSummary&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.completed, _this.completed) || other.completed == _this.completed));
}


@override
int get hashCode {
  final _this = this as TaskSummary;
  return Object.hash(runtimeType,_this.total,_this.completed);
}

@override
String toString() {
  final _this = this as TaskSummary;
  return 'TaskSummary(total: ${_this.total}, completed: ${_this.completed})';
}


}

/// @nodoc
abstract mixin class $TaskSummaryCopyWith<$Res>  {
  factory $TaskSummaryCopyWith(TaskSummary value, $Res Function(TaskSummary) _then) = _$TaskSummaryCopyWithImpl;
@useResult
$Res call({
 int total, int completed
});




}
/// @nodoc
class _$TaskSummaryCopyWithImpl<$Res>
    implements $TaskSummaryCopyWith<$Res> {
  _$TaskSummaryCopyWithImpl(this._self, this._then);

  final TaskSummary _self;
  final $Res Function(TaskSummary) _then;

/// Create a copy of TaskSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? completed = null,}) {
  return _then(TaskSummary(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSummary].
extension TaskSummaryPatterns on TaskSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSummary value)  $default,){
final _that = this;
switch (_that) {
case _TaskSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskSummary() when $default != null:
return $default(_that.total,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int completed)  $default,) {final _that = this;
switch (_that) {
case _TaskSummary():
return $default(_that.total,_that.completed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int completed)?  $default,) {final _that = this;
switch (_that) {
case _TaskSummary() when $default != null:
return $default(_that.total,_that.completed);case _:
  return null;

}
}

}

/// @nodoc


class _TaskSummary extends TaskSummary {
  const _TaskSummary({this.total = 0, this.completed = 0}): super._();
  

@override@JsonKey() final  int total;
@override@JsonKey() final  int completed;

/// Create a copy of TaskSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSummaryCopyWith<_TaskSummary> get copyWith => __$TaskSummaryCopyWithImpl<_TaskSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSummary&&(identical(other.total, total) || other.total == total)&&(identical(other.completed, completed) || other.completed == completed));
}


@override
int get hashCode {
    return Object.hash(runtimeType,total,completed);
}

@override
String toString() {
    return 'TaskSummary(total: $total, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$TaskSummaryCopyWith<$Res> implements $TaskSummaryCopyWith<$Res> {
  factory _$TaskSummaryCopyWith(_TaskSummary value, $Res Function(_TaskSummary) _then) = __$TaskSummaryCopyWithImpl;
@override @useResult
$Res call({
 int total, int completed
});




}
/// @nodoc
class __$TaskSummaryCopyWithImpl<$Res>
    implements _$TaskSummaryCopyWith<$Res> {
  __$TaskSummaryCopyWithImpl(this._self, this._then);

  final _TaskSummary _self;
  final $Res Function(_TaskSummary) _then;

/// Create a copy of TaskSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? completed = null,}) {
  return _then(_TaskSummary(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
