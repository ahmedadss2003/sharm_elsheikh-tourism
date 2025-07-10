import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/home/domain/repos/all_tours_repository.dart';

class GetAllToursRepoImpl implements GetAllToursRepo {
  final ApiService apiService;

  GetAllToursRepoImpl({required this.apiService});
  @override
  Future<List<TourModel>> getAllTours() {
    return apiService.getAllTours();
  }
}
