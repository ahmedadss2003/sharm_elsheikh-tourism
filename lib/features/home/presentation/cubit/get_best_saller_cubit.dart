import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/home/domain/usecases/get_all_tours_usecase.dart';

part 'get_best_saller_state.dart';

class GetAllToursCubit extends Cubit<GetAllToursState> {
  final GetAllToursUseCase getAllToursUseCase;
  GetAllToursCubit(this.getAllToursUseCase) : super(GetAllTourInitial());
  void getAllTours() async {
    emit(GetAllTourLoading());
    try {
      final tours = await getAllToursUseCase.call();
      emit(GetAllTourSuccess(tours));
    } catch (e) {
      emit(GetAllTourError(e.toString()));
    }
  }
}
