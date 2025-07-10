import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/place_detials/domain/repos/best_sall_repo.dart';

class BestSallRepoImpl implements BestSallRepo {
  final ApiService apiService;

  BestSallRepoImpl({required this.apiService});

  @override
  Future<List<TourModel>> getBesSallTours() {
    return apiService.getAllTours();
  }
}
