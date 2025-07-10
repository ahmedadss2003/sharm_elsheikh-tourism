import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_website/core/network/api_service.dart';
import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';
import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_booking_form.dart';

class TransportationBookingCard extends StatelessWidget {
  final String title;
  final String price;
  final String currency;
  final String fromLocation;
  final String toLocation;
  final TransportationModel transportationModel;
  final double width;

  const TransportationBookingCard({
    super.key,
    this.title = "Mini Bus 8 Pax",
    this.price = "25",
    this.currency = "\$",
    this.fromLocation = "From Sharm el Sheikh Airport",
    this.toLocation = "your hotel in sharm el sheikh",
    required this.transportationModel,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionParts = transportationModel.description.split(" To ");
    final toLocation = descriptionParts.length > 1 ? descriptionParts[1] : "";

    // Dynamic font size and padding based on card width
    final double fontSize =
        width < 400
            ? 16
            : width < 600
            ? 18
            : 22;
    final double priceFontSize =
        width < 400
            ? 18
            : width < 600
            ? 24
            : 32;
    final double padding = width < 400 ? 12 : 16;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              width < 400
                  ? 200
                  : width < 600
                  ? 240
                  : 280, // Adjust height based on screen size
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min, // Allow card to size based on content
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(padding),
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                transportationModel.typeBus,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Price
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: priceFontSize,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: currency,
                            style: TextStyle(fontSize: priceFontSize * 0.7),
                          ),
                          TextSpan(text: transportationModel.price.toString()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: padding),
                  // Full Description
                  Text(
                    transportationModel.description,
                    style: TextStyle(
                      fontSize: fontSize * 0.8,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Book Now Button (takes remaining space at bottom)
            Padding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BlocProvider(
                              create:
                                  (context) => TransportationBookingCubit(
                                    ApiService(Dio()),
                                  ),
                              child: TransportBookingForm(
                                transportationModel: transportationModel,
                              ),
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5555),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: padding * 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: fontSize * 0.9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
