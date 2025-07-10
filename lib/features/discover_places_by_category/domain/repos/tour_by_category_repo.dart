import 'package:tourist_website/core/models/tour_model.dart';

abstract class TourByCategoryRepo {
  Future<List<TourModel>> getTourByCategory(String keyword);
}
