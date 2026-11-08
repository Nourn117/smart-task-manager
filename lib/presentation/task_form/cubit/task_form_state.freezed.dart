// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskFormState {

 TaskFormStatus get status;/// The task being edited, null when creating a new one.
 Task? get initialTask; String? get errorMessage;
/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskFormStateCopyWith<TaskFormState> get copyWith => _$TaskFormStateCopyWithImpl<TaskFormState>(this as TaskFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.initialTask, _this.initialTask) || other.initialTask == _this.initialTask)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as TaskFormState;
  return Object.hash(runtimeType,_this.status,_this.initialTask,_this.errorMessage);
}

@override
String toString() {
  final _this = this as TaskFormState;
  return 'TaskFormState(status: ${_this.status}, initialTask: ${_this.initialTask}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $TaskFormStateCopyWith<$Res>  {
  factory $TaskFormStateCopyWith(TaskFormState value, $Res Function(TaskFormState) _then) = _$TaskFormStateCopyWithImpl;
@useResult
$Res call({
 TaskFormStatus status, Task? initialTask, String? errorMessage
});


$TaskCopyWith<$Res>? get initialTask;

}
/// @nodoc
class _$TaskFormStateCopyWithImpl<$Res>
    implements $TaskFormStateCopyWith<$Res> {
  _$TaskFormStateCopyWithImpl(this._self, this._then);

  final TaskFormState _self;
  final $Res Function(TaskFormState) _then;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? initialTask = freezed,Object? errorMessage = freezed,}) {
  return _then(TaskFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskFormStatus,initialTask: freezed == initialTask ? _self.initialTask : initialTask // ignore: cast_nullable_to_non_nullable
as Task?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get initialTask {
    if (_self.initialTask == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.initialTask!, (value) {
    return _then(_self.copyWith(initialTask: value));
  });
}
}


/// Adds pattern-matching-related methods to [TaskFormState].
extension TaskFormStatePatterns on TaskFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskFormState value)  $default,){
final _that = this;
switch (_that) {
case _TaskFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskFormState value)?  $default,){
final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TaskFormStatus status,  Task? initialTask,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
return $default(_that.status,_that.initialTask,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TaskFormStatus status,  Task? initialTask,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TaskFormState():
return $default(_that.status,_that.initialTask,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TaskFormStatus status,  Task? initialTask,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TaskFormState() when $default != null:
return $default(_that.status,_that.initialTask,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TaskFormState implements TaskFormState {
  const _TaskFormState({this.status = TaskFormStatus.loading, this.initialTask, this.errorMessage});
  

@override@JsonKey() final  TaskFormStatus status;
/// The task being edited, null when creating a new one.
@override final  Task? initialTask;
@override final  String? errorMessage;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskFormStateCopyWith<_TaskFormState> get copyWith => __$TaskFormStateCopyWithImpl<_TaskFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.initialTask, initialTask) || other.initialTask == initialTask)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,initialTask,errorMessage);
}

@override
String toString() {
    return 'TaskFormState(status: $status, initialTask: $initialTask, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TaskFormStateCopyWith<$Res> implements $TaskFormStateCopyWith<$Res> {
  factory _$TaskFormStateCopyWith(_TaskFormState value, $Res Function(_TaskFormState) _then) = __$TaskFormStateCopyWithImpl;
@override @useResult
$Res call({
 TaskFormStatus status, Task? initialTask, String? errorMessage
});


@override $TaskCopyWith<$Res>? get initialTask;

}
/// @nodoc
class __$TaskFormStateCopyWithImpl<$Res>
    implements _$TaskFormStateCopyWith<$Res> {
  __$TaskFormStateCopyWithImpl(this._self, this._then);

  final _TaskFormState _self;
  final $Res Function(_TaskFormState) _then;

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? initialTask = freezed,Object? errorMessage = freezed,}) {
  return _then(_TaskFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskFormStatus,initialTask: freezed == initialTask ? _self.initialTask : initialTask // ignore: cast_nullable_to_non_nullable
as Task?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TaskFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res>? get initialTask {
    if (_self.initialTask == null) {
    return null;
  }

  return $TaskCopyWith<$Res>(_self.initialTask!, (value) {
    return _then(_self.copyWith(initialTask: value));
  });
}
}

// dart format on
