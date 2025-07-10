import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/domain/usecases/get_tours_by_category_usecase.dart';

part 'tour_by_category_state.dart';

class TourByCategoryCubit extends Cubit<TourByCategoryState> {
  final GetToursByCategoryUsecase toursByCategoryUsecase ;
  TourByCategoryCubit(this.toursByCategoryUsecase) : super(TourByCategoryInitial());
  void getTourByCategory (String keyword)async{
    emit(TourByCategoryLoading());
    try{
      final tours = await toursByCategoryUsecase.call(keyword);
      emit(TourByCategorySuccess(tours));
    }catch(e){
      emit(TourByCategoryError(e.toString()));
    }
    
  }

}
