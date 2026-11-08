// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskQuery {

 String get searchTerm; TaskStatusFilter get status; TaskPriority? get priority; TaskCategory? get category; TaskSortOption get sortBy; int get limit;
/// Create a copy of TaskQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskQueryCopyWith<TaskQuery> get copyWith => _$TaskQueryCopyWithImpl<TaskQuery>(this as TaskQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TaskQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskQuery&&(identical(other.searchTerm, _this.searchTerm) || other.searchTerm == _this.searchTerm)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.sortBy, _this.sortBy) || other.sortBy == _this.sortBy)&&(identical(other.limit, _this.limit) || other.limit == _this.limit));
}


@override
int get hashCode {
  final _this = this as TaskQuery;
  return Object.hash(runtimeType,_this.searchTerm,_this.status,_this.priority,_this.category,_this.sortBy,_this.limit);
}

@override
String toString() {
  final _this = this as TaskQuery;
  return 'TaskQuery(searchTerm: ${_this.searchTerm}, status: ${_this.status}, priority: ${_this.priority}, category: ${_this.category}, sortBy: ${_this.sortBy}, limit: ${_this.limit})';
}


}

/// @nodoc
abstract mixin class $TaskQueryCopyWith<$Res>  {
  factory $TaskQueryCopyWith(TaskQuery value, $Res Function(TaskQuery) _then) = _$TaskQueryCopyWithImpl;
@useResult
$Res call({
 String searchTerm, TaskStatusFilter status, TaskPriority? priority, TaskCategory? category, TaskSortOption sortBy, int limit
});




}
/// @nodoc
class _$TaskQueryCopyWithImpl<$Res>
    implements $TaskQueryCopyWith<$Res> {
  _$TaskQueryCopyWithImpl(this._self, this._then);

  final TaskQuery _self;
  final $Res Function(TaskQuery) _then;

/// Create a copy of TaskQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchTerm = null,Object? status = null,Object? priority = freezed,Object? category = freezed,Object? sortBy = null,Object? limit = null,}) {
  return _then(TaskQuery(
searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as TaskSortOption,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskQuery].
extension TaskQueryPatterns on TaskQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskQuery value)  $default,){
final _that = this;
switch (_that) {
case _TaskQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskQuery value)?  $default,){
final _that = this;
switch (_that) {
case _TaskQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchTerm,  TaskStatusFilter status,  TaskPriority? priority,  TaskCategory? category,  TaskSortOption sortBy,  int limit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskQuery() when $default != null:
return $default(_that.searchTerm,_that.status,_that.priority,_that.category,_that.sortBy,_that.limit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchTerm,  TaskStatusFilter status,  TaskPriority? priority,  TaskCategory? category,  TaskSortOption sortBy,  int limit)  $default,) {final _that = this;
switch (_that) {
case _TaskQuery():
return $default(_that.searchTerm,_that.status,_that.priority,_that.category,_that.sortBy,_that.limit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchTerm,  TaskStatusFilter status,  TaskPriority? priority,  TaskCategory? category,  TaskSortOption sortBy,  int limit)?  $default,) {final _that = this;
switch (_that) {
case _TaskQuery() when $default != null:
return $default(_that.searchTerm,_that.status,_that.priority,_that.category,_that.sortBy,_that.limit);case _:
  return null;

}
}

}

/// @nodoc


class _TaskQuery implements TaskQuery {
  const _TaskQuery({this.searchTerm = '', this.status = TaskStatusFilter.all, this.priority, this.category, this.sortBy = TaskSortOption.newestFirst, this.limit = 20});
  

@override@JsonKey() final  String searchTerm;
@override@JsonKey() final  TaskStatusFilter status;
@override final  TaskPriority? priority;
@override final  TaskCategory? category;
@override@JsonKey() final  TaskSortOption sortBy;
@override@JsonKey() final  int limit;

/// Create a copy of TaskQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskQueryCopyWith<_TaskQuery> get copyWith => __$TaskQueryCopyWithImpl<_TaskQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskQuery&&(identical(other.searchTerm, searchTerm) || other.searchTerm == searchTerm)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.category, category) || other.category == category)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode {
    return Object.hash(runtimeType,searchTerm,status,priority,category,sortBy,limit);
}

@override
String toString() {
    return 'TaskQuery(searchTerm: $searchTerm, status: $status, priority: $priority, category: $category, sortBy: $sortBy, limit: $limit)';
}


}

/// @nodoc
abstract mixin class _$TaskQueryCopyWith<$Res> implements $TaskQueryCopyWith<$Res> {
  factory _$TaskQueryCopyWith(_TaskQuery value, $Res Function(_TaskQuery) _then) = __$TaskQueryCopyWithImpl;
@override @useResult
$Res call({
 String searchTerm, TaskStatusFilter status, TaskPriority? priority, TaskCategory? category, TaskSortOption sortBy, int limit
});




}
/// @nodoc
class __$TaskQueryCopyWithImpl<$Res>
    implements _$TaskQueryCopyWith<$Res> {
  __$TaskQueryCopyWithImpl(this._self, this._then);

  final _TaskQuery _self;
  final $Res Function(_TaskQuery) _then;

/// Create a copy of TaskQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchTerm = null,Object? status = null,Object? priority = freezed,Object? category = freezed,Object? sortBy = null,Object? limit = null,}) {
  return _then(_TaskQuery(
searchTerm: null == searchTerm ? _self.searchTerm : searchTerm // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatusFilter,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as TaskSortOption,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
