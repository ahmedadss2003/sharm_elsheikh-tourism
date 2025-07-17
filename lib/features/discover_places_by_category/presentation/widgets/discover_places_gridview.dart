import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/features/discover_places_by_category/presentation/cubit/tour_by_category_cubit.dart';
import 'package:tourist_website/core/widgets/trip_card.dart';

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
              if (tourModel.isEmpty) {
                return Center(
                  child: Text(
                    'There Is No $categoryName Tours Available Now Please Try Again Later',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = _getCrossAxisCount(
                    constraints.maxWidth,
                  );
                  final shouldCenter =
                      tourModel.length < crossAxisCount &&
                      tourModel.length <= 3;

                  if (shouldCenter) {
                    // Center the items when there are fewer items than columns
                    return Center(
                      child: Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        alignment: WrapAlignment.center,
                        children:
                            tourModel.map((tour) {
                              return SizedBox(
                                width: _getItemWidth(
                                  constraints.maxWidth,
                                  crossAxisCount,
                                ),
                                child: TripCard(
                                  tourModel: tour,
                                  width: constraints.maxWidth,
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  } else {
                    // Use normal grid when there are enough items
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
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
                  }
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

  double _getChildAspectRatio(double width) {
    if (width > 1200) return 0.75;
    if (width > 900) return 0.8;
    if (width > 600) return 0.75;
    return 1.4;
  }

  double _getItemWidth(double screenWidth, int crossAxisCount) {
    final spacing = 15.0 * (crossAxisCount - 1);
    final availableWidth = screenWidth - spacing;
    return availableWidth / crossAxisCount;
  }
}
