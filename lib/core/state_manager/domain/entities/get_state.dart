import 'package:todo_app/core/errors/domain/entities/failure.dart';
import 'package:todo_app/core/state_manager/domain/entities/base_state.dart';

sealed class GetState extends BaseState {}

final class InitialGetState extends GetState {}

final class LoadingGetState extends GetState {}

final class SuccessGetState<T> extends GetState {
  final T item;

  SuccessGetState(this.item);

  @override
  List<Object?> get props => [item];
}

final class FailureGetState extends GetState {
  final Failure failure;

  FailureGetState(this.failure);

  @override
  List<Object?> get props => [failure];
}
