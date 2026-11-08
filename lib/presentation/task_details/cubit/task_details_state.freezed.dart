// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TaskDetailsState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TaskDetailsState()';
}


}

/// @nodoc
class $TaskDetailsStateCopyWith<$Res>  {
$TaskDetailsStateCopyWith(TaskDetailsState _, $Res Function(TaskDetailsState) __);
}


/// Adds pattern-matching-related methods to [TaskDetailsState].
extension TaskDetailsStatePatterns on TaskDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TaskDetailsLoading value)?  loading,TResult Function( TaskDetailsLoaded value)?  loaded,TResult Function( TaskDetailsNotFound value)?  notFound,TResult Function( TaskDetailsFailure value)?  failure,TResult Function( TaskDetailsCompletionToggled value)?  completionToggled,TResult Function( TaskDetailsDeleted value)?  deleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TaskDetailsLoading() when loading != null:
return loading(_that);case TaskDetailsLoaded() when loaded != null:
return loaded(_that);case TaskDetailsNotFound() when notFound != null:
return notFound(_that);case TaskDetailsFailure() when failure != null:
return failure(_that);case TaskDetailsCompletionToggled() when completionToggled != null:
return completionToggled(_that);case TaskDetailsDeleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TaskDetailsLoading value)  loading,required TResult Function( TaskDetailsLoaded value)  loaded,required TResult Function( TaskDetailsNotFound value)  notFound,required TResult Function( TaskDetailsFailure value)  failure,required TResult Function( TaskDetailsCompletionToggled value)  completionToggled,required TResult Function( TaskDetailsDeleted value)  deleted,}){
final _that = this;
switch (_that) {
case TaskDetailsLoading():
return loading(_that);case TaskDetailsLoaded():
return loaded(_that);case TaskDetailsNotFound():
return notFound(_that);case TaskDetailsFailure():
return failure(_that);case TaskDetailsCompletionToggled():
return completionToggled(_that);case TaskDetailsDeleted():
return deleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TaskDetailsLoading value)?  loading,TResult? Function( TaskDetailsLoaded value)?  loaded,TResult? Function( TaskDetailsNotFound value)?  notFound,TResult? Function( TaskDetailsFailure value)?  failure,TResult? Function( TaskDetailsCompletionToggled value)?  completionToggled,TResult? Function( TaskDetailsDeleted value)?  deleted,}){
final _that = this;
switch (_that) {
case TaskDetailsLoading() when loading != null:
return loading(_that);case TaskDetailsLoaded() when loaded != null:
return loaded(_that);case TaskDetailsNotFound() when notFound != null:
return notFound(_that);case TaskDetailsFailure() when failure != null:
return failure(_that);case TaskDetailsCompletionToggled() when completionToggled != null:
return completionToggled(_that);case TaskDetailsDeleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( Task task,  bool isBusy,  String? errorMessage)?  loaded,TResult Function()?  notFound,TResult Function( String message)?  failure,TResult Function( bool isCompleted)?  completionToggled,TResult Function()?  deleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TaskDetailsLoading() when loading != null:
return loading();case TaskDetailsLoaded() when loaded != null:
return loaded(_that.task,_that.isBusy,_that.errorMessage);case TaskDetailsNotFound() when notFound != null:
return notFound();case TaskDetailsFailure() when failure != null:
return failure(_that.message);case TaskDetailsCompletionToggled() when completionToggled != null:
return completionToggled(_that.isCompleted);case TaskDetailsDeleted() when deleted != null:
return deleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( Task task,  bool isBusy,  String? errorMessage)  loaded,required TResult Function()  notFound,required TResult Function( String message)  failure,required TResult Function( bool isCompleted)  completionToggled,required TResult Function()  deleted,}) {final _that = this;
switch (_that) {
case TaskDetailsLoading():
return loading();case TaskDetailsLoaded():
return loaded(_that.task,_that.isBusy,_that.errorMessage);case TaskDetailsNotFound():
return notFound();case TaskDetailsFailure():
return failure(_that.message);case TaskDetailsCompletionToggled():
return completionToggled(_that.isCompleted);case TaskDetailsDeleted():
return deleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( Task task,  bool isBusy,  String? errorMessage)?  loaded,TResult? Function()?  notFound,TResult? Function( String message)?  failure,TResult? Function( bool isCompleted)?  completionToggled,TResult? Function()?  deleted,}) {final _that = this;
switch (_that) {
case TaskDetailsLoading() when loading != null:
return loading();case TaskDetailsLoaded() when loaded != null:
return loaded(_that.task,_that.isBusy,_that.errorMessage);case TaskDetailsNotFound() when notFound != null:
return notFound();case TaskDetailsFailure() when failure != null:
return failure(_that.message);case TaskDetailsCompletionToggled() when completionToggled != null:
return completionToggled(_that.isCompleted);case TaskDetailsDeleted() when deleted != null:
return deleted();case _:
  return null;

}
}

}

/// @nodoc


class TaskDetailsLoading implements TaskDetailsState {
  const TaskDetailsLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TaskDetailsState.loading()';
}


}




/// @nodoc


class TaskDetailsLoaded implements TaskDetailsState {
  const TaskDetailsLoaded(this.task, {this.isBusy = false, this.errorMessage});
  

 final  Task task;
@JsonKey() final  bool isBusy;
 final  String? errorMessage;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailsLoadedCopyWith<TaskDetailsLoaded> get copyWith => _$TaskDetailsLoadedCopyWithImpl<TaskDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsLoaded&&(identical(other.task, task) || other.task == task)&&(identical(other.isBusy, isBusy) || other.isBusy == isBusy)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,task,isBusy,errorMessage);
}

@override
String toString() {
    return 'TaskDetailsState.loaded(task: $task, isBusy: $isBusy, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TaskDetailsLoadedCopyWith<$Res> implements $TaskDetailsStateCopyWith<$Res> {
  factory $TaskDetailsLoadedCopyWith(TaskDetailsLoaded value, $Res Function(TaskDetailsLoaded) _then) = _$TaskDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 Task task, bool isBusy, String? errorMessage
});


$TaskCopyWith<$Res> get task;

}
/// @nodoc
class _$TaskDetailsLoadedCopyWithImpl<$Res>
    implements $TaskDetailsLoadedCopyWith<$Res> {
  _$TaskDetailsLoadedCopyWithImpl(this._self, this._then);

  final TaskDetailsLoaded _self;
  final $Res Function(TaskDetailsLoaded) _then;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? task = null,Object? isBusy = null,Object? errorMessage = freezed,}) {
  return _then(TaskDetailsLoaded(
null == task ? _self.task : task // ignore: cast_nullable_to_non_nullable
as Task,isBusy: null == isBusy ? _self.isBusy : isBusy // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskCopyWith<$Res> get task {
  
  return $TaskCopyWith<$Res>(_self.task, (value) {
    return _then(_self.copyWith(task: value));
  });
}
}

/// @nodoc


class TaskDetailsNotFound implements TaskDetailsState {
  const TaskDetailsNotFound();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsNotFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TaskDetailsState.notFound()';
}


}




/// @nodoc


class TaskDetailsFailure implements TaskDetailsState {
  const TaskDetailsFailure(this.message);
  

 final  String message;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailsFailureCopyWith<TaskDetailsFailure> get copyWith => _$TaskDetailsFailureCopyWithImpl<TaskDetailsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'TaskDetailsState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $TaskDetailsFailureCopyWith<$Res> implements $TaskDetailsStateCopyWith<$Res> {
  factory $TaskDetailsFailureCopyWith(TaskDetailsFailure value, $Res Function(TaskDetailsFailure) _then) = _$TaskDetailsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TaskDetailsFailureCopyWithImpl<$Res>
    implements $TaskDetailsFailureCopyWith<$Res> {
  _$TaskDetailsFailureCopyWithImpl(this._self, this._then);

  final TaskDetailsFailure _self;
  final $Res Function(TaskDetailsFailure) _then;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TaskDetailsFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TaskDetailsCompletionToggled implements TaskDetailsState {
  const TaskDetailsCompletionToggled({required this.isCompleted});
  

 final  bool isCompleted;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskDetailsCompletionToggledCopyWith<TaskDetailsCompletionToggled> get copyWith => _$TaskDetailsCompletionToggledCopyWithImpl<TaskDetailsCompletionToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsCompletionToggled&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isCompleted);
}

@override
String toString() {
    return 'TaskDetailsState.completionToggled(isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $TaskDetailsCompletionToggledCopyWith<$Res> implements $TaskDetailsStateCopyWith<$Res> {
  factory $TaskDetailsCompletionToggledCopyWith(TaskDetailsCompletionToggled value, $Res Function(TaskDetailsCompletionToggled) _then) = _$TaskDetailsCompletionToggledCopyWithImpl;
@useResult
$Res call({
 bool isCompleted
});




}
/// @nodoc
class _$TaskDetailsCompletionToggledCopyWithImpl<$Res>
    implements $TaskDetailsCompletionToggledCopyWith<$Res> {
  _$TaskDetailsCompletionToggledCopyWithImpl(this._self, this._then);

  final TaskDetailsCompletionToggled _self;
  final $Res Function(TaskDetailsCompletionToggled) _then;

/// Create a copy of TaskDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isCompleted = null,}) {
  return _then(TaskDetailsCompletionToggled(
isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class TaskDetailsDeleted implements TaskDetailsState {
  const TaskDetailsDeleted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskDetailsDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TaskDetailsState.deleted()';
}


}




// dart format on
