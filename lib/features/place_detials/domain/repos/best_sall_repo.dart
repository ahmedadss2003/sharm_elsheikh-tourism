import 'package:tourist_website/core/models/tour_model.dart';

abstract class BestSallRepo {
  Future<List<TourModel>> getBesSallTours();
}
