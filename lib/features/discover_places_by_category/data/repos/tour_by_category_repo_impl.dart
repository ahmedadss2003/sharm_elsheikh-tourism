import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/discover_places_by_category/domain/repos/tour_by_category_repo.dart';

class TourByCategoryRepoImpl implements TourByCategoryRepo {
  final ApiService apiService;

  TourByCategoryRepoImpl({required this.apiService});
  @override
  Future<List<TourModel>> getTourByCategory(String keyword) {
    return apiService.searchToursByCategory(keyword);
  }
}
