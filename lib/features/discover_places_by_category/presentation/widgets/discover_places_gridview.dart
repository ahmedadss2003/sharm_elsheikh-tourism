import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/cubit/tour_by_category_cubit.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/widgets/place_card.dart';

class CustomDiscoverPlacesGridView extends StatelessWidget {
  const CustomDiscoverPlacesGridView({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocBuilder<TourByCategoryCubit, TourByCategoryState>(
          builder: (context, state) {
            if (state is TourByCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TourByCategorySuccess) {
              final List<TourModel> tourModel = state.tours;
              return LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: _getChildAspectRatio(
                        constraints.maxWidth,
                      ),
                    ),
                    itemCount: tourModel.length,
                    itemBuilder: (context, index) {
                      return TripCard(
                        tourModel: tourModel[index],
                        width: constraints.maxWidth,
                      );
                    },
                  );
                },
              );
            } else if (state is TourByCategoryError) {
              return const Center(child: Text('Error'));
            } else {
              return const Center(child: Text('No Data'));
            }
          },
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  // Helper method to determine aspect ratio based on screen width
  double _getChildAspectRatio(double width) {
    if (width > 1200) return 0.75;
    if (width > 900) return 0.8;
    if (width > 600) return 0.75;
    return 1.4;
  }
}
