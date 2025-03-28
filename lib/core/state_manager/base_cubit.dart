import 'package:bloc/bloc.dart';
import 'package:todo_app/core/state_manager/entities/base_state.dart';

abstract class BaseCubit<T extends BaseState> extends Cubit<T> {
  BaseCubit({required T initialState}) : super(initialState);
}
