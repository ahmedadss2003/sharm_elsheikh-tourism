import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/place_detials/domain/uses_case/best_sall_usecase.dart';

part 'best_salle_state.dart';

class BestSalleCubit extends Cubit<BestSalleState> {
  final BestSallUsecase bestSalleUseCase;
  BestSalleCubit(this.bestSalleUseCase) : super(BestSalleInitial());
  void getBestSalleTours() async {
    emit(BestSalleLoading());
    try {
      final response = await bestSalleUseCase.call();
      emit(BestSalleSuccess(response));
    } catch (e) {
      emit(BestSalleError(e.toString()));
    }
  }
}
