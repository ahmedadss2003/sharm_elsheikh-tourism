import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/manager/get_transportation_cubit/get_transportation_cubit.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/book_transport_card.dart';

class TransportationGridView extends StatelessWidget {
  const TransportationGridView({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTransportationCubit, GetTransportationState>(
      builder: (context, state) {
        if (state is GetTransportationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetTransportationSuccess) {
          final List<TransportationModel> transportationModel =
              state.transportationModel;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: transportationModel.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  width < 740
                      ? 1
                      : width < 1112
                      ? 2
                      : 3,
              childAspectRatio:
                  width < 400
                      ? 0.9
                      : width < 740
                      ? 1.1
                      : width < 1112
                      ? 0.95
                      : 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return TransportationBookingCard(
                width: width,
                transportationModel: transportationModel[index],
              );
            },
          );
        } else {
          return const Center(child: Text('Try Later!'));
        }
      },
    );
  }
}
