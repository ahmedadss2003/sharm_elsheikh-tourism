import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/domain/repos/tour_by_category_repo.dart';

class GetToursByCategoryUsecase {
  final TourByCategoryRepo tourByCategoryRepo;
  GetToursByCategoryUsecase( this.tourByCategoryRepo);
  Future<List<TourModel>> call( String keyword){
    return tourByCategoryRepo.getTourByCategory(keyword) ;
  }
}