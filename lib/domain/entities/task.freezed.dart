// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Task {

/// Stable local id (UUID), never depends on the server.
 String get id;/// Server id, null until the task exists remotely.
 int? get remoteId; String get title; String? get description; TaskPriority get priority; TaskCategory get category; DateTime? get dueDate; bool get isCompleted; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Task;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.remoteId, _this.remoteId) || other.remoteId == _this.remoteId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.syncStatus, _this.syncStatus) || other.syncStatus == _this.syncStatus));
}


@override
int get hashCode {
  final _this = this as Task;
  return Object.hash(runtimeType,_this.id,_this.remoteId,_this.title,_this.description,_this.priority,_this.category,_this.dueDate,_this.isCompleted,_this.createdAt,_this.updatedAt,_this.syncStatus);
}

@override
String toString() {
  final _this = this as Task;
  return 'Task(id: ${_this.id}, remoteId: ${_this.remoteId}, title: ${_this.title}, description: ${_this.description}, priority: ${_this.priority}, category: ${_this.category}, dueDate: ${_this.dueDate}, isCompleted: ${_this.isCompleted}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, syncStatus: ${_this.syncStatus})';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String id, int? remoteId, String title, String? description, TaskPriority priority, TaskCategory category, DateTime? dueDate, bool isCompleted, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? remoteId = freezed,Object? title = null,Object? description = freezed,Object? priority = null,Object? category = null,Object? dueDate = freezed,Object? isCompleted = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,}) {
  return _then(Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int? remoteId,  String title,  String? description,  TaskPriority priority,  TaskCategory category,  DateTime? dueDate,  bool isCompleted,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.remoteId,_that.title,_that.description,_that.priority,_that.category,_that.dueDate,_that.isCompleted,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int? remoteId,  String title,  String? description,  TaskPriority priority,  TaskCategory category,  DateTime? dueDate,  bool isCompleted,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.id,_that.remoteId,_that.title,_that.description,_that.priority,_that.category,_that.dueDate,_that.isCompleted,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int? remoteId,  String title,  String? description,  TaskPriority priority,  TaskCategory category,  DateTime? dueDate,  bool isCompleted,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.id,_that.remoteId,_that.title,_that.description,_that.priority,_that.category,_that.dueDate,_that.isCompleted,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
  return null;

}
}

}

/// @nodoc


class _Task implements Task {
  const _Task({required this.id, this.remoteId, required this.title, this.description, required this.priority, required this.category, this.dueDate, this.isCompleted = false, required this.createdAt, required this.updatedAt, this.syncStatus = SyncStatus.pending});
  

/// Stable local id (UUID), never depends on the server.
@override final  String id;
/// Server id, null until the task exists remotely.
@override final  int? remoteId;
@override final  String title;
@override final  String? description;
@override final  TaskPriority priority;
@override final  TaskCategory category;
@override final  DateTime? dueDate;
@override@JsonKey() final  bool isCompleted;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  SyncStatus syncStatus;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.category, category) || other.category == category)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,remoteId,title,description,priority,category,dueDate,isCompleted,createdAt,updatedAt,syncStatus);
}

@override
String toString() {
    return 'Task(id: $id, remoteId: $remoteId, title: $title, description: $description, priority: $priority, category: $category, dueDate: $dueDate, isCompleted: $isCompleted, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String id, int? remoteId, String title, String? description, TaskPriority priority, TaskCategory category, DateTime? dueDate, bool isCompleted, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? remoteId = freezed,Object? title = null,Object? description = freezed,Object? priority = null,Object? category = null,Object? dueDate = freezed,Object? isCompleted = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,}) {
  return _then(_Task(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TaskPriority,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TaskCategory,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}


}

// dart format on
