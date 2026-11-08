// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksState {

 TasksStatus get status; TaskQuery get query; List<Task> get tasks; bool get hasMore; String? get errorMessage;
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksStateCopyWith<TasksState> get copyWith => _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TasksState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.tasks, _this.tasks)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as TasksState;
  return Object.hash(runtimeType,_this.status,_this.query,const DeepCollectionEquality().hash(_this.tasks),_this.hasMore,_this.errorMessage);
}

@override
String toString() {
  final _this = this as TasksState;
  return 'TasksState(status: ${_this.status}, query: ${_this.query}, tasks: ${_this.tasks}, hasMore: ${_this.hasMore}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res>  {
  factory $TasksStateCopyWith(TasksState value, $Res Function(TasksState) _then) = _$TasksStateCopyWithImpl;
@useResult
$Res call({
 TasksStatus status, TaskQuery query, List<Task> tasks, bool hasMore, String? errorMessage
});


$TaskQueryCopyWith<$Res> get query;

}
/// @nodoc
class _$TasksStateCopyWithImpl<$Res>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? query = null,Object? tasks = null,Object? hasMore = null,Object? errorMessage = freezed,}) {
  return _then(TasksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as TaskQuery,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskQueryCopyWith<$Res> get query {
  
  return $TaskQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}
}


/// Adds pattern-matching-related methods to [TasksState].
extension TasksStatePatterns on TasksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TasksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TasksState value)  $default,){
final _that = this;
switch (_that) {
case _TasksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TasksState value)?  $default,){
final _that = this;
switch (_that) {
case _TasksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TasksStatus status,  TaskQuery query,  List<Task> tasks,  bool hasMore,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.status,_that.query,_that.tasks,_that.hasMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TasksStatus status,  TaskQuery query,  List<Task> tasks,  bool hasMore,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TasksState():
return $default(_that.status,_that.query,_that.tasks,_that.hasMore,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TasksStatus status,  TaskQuery query,  List<Task> tasks,  bool hasMore,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TasksState() when $default != null:
return $default(_that.status,_that.query,_that.tasks,_that.hasMore,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TasksState extends TasksState {
  const _TasksState({this.status = TasksStatus.loading, this.query = const TaskQuery(),  List<Task> tasks = const <Task>[], this.hasMore = false, this.errorMessage}): _tasks = tasks,super._();
  

@override@JsonKey() final  TasksStatus status;
@override@JsonKey() final  TaskQuery query;
 final  List<Task> _tasks;
@override@JsonKey() List<Task> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

@override@JsonKey() final  bool hasMore;
@override final  String? errorMessage;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksStateCopyWith<_TasksState> get copyWith => __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksState&&(identical(other.status, status) || other.status == status)&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.tasks, _tasks)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,query,const DeepCollectionEquality().hash(_tasks),hasMore,errorMessage);
}

@override
String toString() {
    return 'TasksState(status: $status, query: $query, tasks: $tasks, hasMore: $hasMore, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res> implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(_TasksState value, $Res Function(_TasksState) _then) = __$TasksStateCopyWithImpl;
@override @useResult
$Res call({
 TasksStatus status, TaskQuery query, List<Task> tasks, bool hasMore, String? errorMessage
});


@override $TaskQueryCopyWith<$Res> get query;

}
/// @nodoc
class __$TasksStateCopyWithImpl<$Res>
    implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? query = null,Object? tasks = null,Object? hasMore = null,Object? errorMessage = freezed,}) {
  return _then(_TasksState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TasksStatus,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as TaskQuery,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<Task>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskQueryCopyWith<$Res> get query {
  
  return $TaskQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}
}

// dart format on
