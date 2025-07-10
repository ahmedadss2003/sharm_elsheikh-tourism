import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/home/domain/repos/all_tours_repository.dart';

class GetAllToursUseCase {
  final GetAllToursRepo repository;

  GetAllToursUseCase(this.repository);

  Future<List<TourModel>> call() => repository.getAllTours();
}
