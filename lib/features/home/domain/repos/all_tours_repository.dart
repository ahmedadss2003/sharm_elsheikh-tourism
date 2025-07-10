import 'package:tourist_website/core/models/tour_model.dart';

abstract class GetAllToursRepo {
  Future<List<TourModel>> getAllTours();
}
