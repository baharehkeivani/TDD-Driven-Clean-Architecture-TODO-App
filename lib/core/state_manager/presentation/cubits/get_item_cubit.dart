import 'package:todo_app/core/state_manager/domain/entities/get_state.dart';

import 'base_cubit.dart';

abstract class GetItemCubit<T> extends BaseCubit<GetState> {
  GetItemCubit(super.initialState);

  Future<void> fetchItem();
}