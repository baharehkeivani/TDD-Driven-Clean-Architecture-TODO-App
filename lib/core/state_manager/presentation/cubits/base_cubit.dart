import 'package:bloc/bloc.dart';
import 'package:todo_app/core/state_manager/domain/entities/base_state.dart';

abstract class BaseCubit<T extends BaseState> extends Cubit<T> {
  BaseCubit(super.initialState);
}
