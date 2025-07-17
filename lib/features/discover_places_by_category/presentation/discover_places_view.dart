import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/discover_places_by_category/data/repos/tour_by_category_repo_impl.dart';
import 'package:tourist_website/features/discover_places_by_category/domain/usecases/get_tours_by_category_usecase.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/cubit/tour_by_category_cubit.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/discover_places_view_body.dart';

class DiscoverPlacesView extends StatelessWidget {
  const DiscoverPlacesView({
    super.key,
    required this.categoryName,
    this.color,
    required this.imageUrl,
  });
  static const routeName = "discover_places";
  final Color? color;
  final String categoryName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => TourByCategoryCubit(
            GetToursByCategoryUsecase(
              TourByCategoryRepoImpl(apiService: ApiService(Dio())),
            ),
          )..getTourByCategory(categoryName),
      child: DiscoverPlacesViewBody(
        categoryName: categoryName,
        color: color!,
        imageUrl: imageUrl,
      ),
    );
  }
}
