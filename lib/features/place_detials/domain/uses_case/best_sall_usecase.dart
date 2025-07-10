import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/place_detials/domain/repos/best_sall_repo.dart';

class BestSallUsecase {
  final BestSallRepo bestSallRepo;

  BestSallUsecase({required this.bestSallRepo});
  Future<List<TourModel>> call() => bestSallRepo.getBesSallTours();
}
