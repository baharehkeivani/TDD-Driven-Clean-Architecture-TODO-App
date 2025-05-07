import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/core/state_manager/entities/get_state.dart';
import 'package:todo_app/core/state_manager/errors/failure.dart';
import 'package:todo_app/features/todo/presentation/cubits/toggle_task_state_cubit.dart';

import '../../data/mock/mocks.mocks.dart';
import '../../domain/entities/task_test.dart';

void main() {
  /// Note: Mockito is not smart enough to generate a dummy value of type 'Either<Failure, Task>'.
  /// So we must consider using either 'provideDummy' or 'provideDummyBuilder' to give Mockito a proper dummy value.
  provideDummy<Either<Failure, bool>>(Right(true));
  provideDummy<Either<Failure, bool>>(Left(UnknownFailure()));

  late MockTasksService mockService;
  late ToggleTaskStateCubit cubit;

  setUp(() {
    mockService = MockTasksService();
    cubit = ToggleTaskStateCubit(mockService);
  });

  group('ToggleTaskStateCubit', () {
    blocTest<ToggleTaskStateCubit, GetState>(
      'emits [LoadingGetState, SuccessGetState] when toggleTasks succeeds',
      build: () {
        when(mockService.toggleTaskState(any)).thenAnswer((_) async => Right(true));
        return cubit;
      },
      act: (cubit) => cubit.toggleTasks(task),
      expect: () => [LoadingGetState(), SuccessGetState<bool>(true)],
    );

    blocTest<ToggleTaskStateCubit, GetState>(
      'emits [LoadingGetState, FailureGetState] when toggleTasks fails',
      build: () {
        when(mockService.toggleTaskState(any)).thenAnswer((_) async => Left(UnknownFailure()));
        return cubit;
      },
      act: (cubit) => cubit.toggleTasks(task),
      expect: () => [LoadingGetState(), FailureGetState(UnknownFailure())],
    );
  });
}
