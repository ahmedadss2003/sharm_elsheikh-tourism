import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/models/tour_model.dart';
import 'package:tourist_website/core/widgets/trip_card.dart';
import 'package:tourist_website/features/home/presentation/manager/best_salle_cubit/get_best_saller_cubit.dart';

class CustomMostPopularGridView extends StatelessWidget {
  const CustomMostPopularGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllToursCubit, GetAllToursState>(
      builder: (context, state) {
        if (state is GetAllTourLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllTourSuccess) {
          final List<TourModel> tours = state.tourList;
          return LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(constraints.maxWidth),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: _getChildAspectRatio(constraints.maxWidth),
                ),
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  return TripCard(
                    tourModel: tours[index],
                    width: constraints.maxWidth,
                  );
                },
              );
            },
          );
        } else if (state is GetAllTourError) {
          return const Text('Please try again');
        }
        return const SizedBox();
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
    if (width > 1200) return 1;
    if (width > 900) return 0.89;
    if (width > 600) return 1.2;
    return 1.4;
  }
}
