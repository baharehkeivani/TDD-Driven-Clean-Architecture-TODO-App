import 'package:todo_app/core/state_manager/entities/base_state.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';

sealed class SetState extends BaseState {}

final class InitialSetState extends SetState {}

final class LoadingSetState extends SetState {}

final class SuccessSetState<T> extends SetState {}

final class FailureSetState extends SetState {
  final Failure failure;

  FailureSetState(this.failure);

  @override
  List<Object?> get props => [failure];
}
