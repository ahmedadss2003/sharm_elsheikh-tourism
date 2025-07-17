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
    this.currency = "£",
    this.fromLocation = "From Sharm el Sheikh Airport",
    this.toLocation = "your hotel in sharm el sheikh",
    required this.transportationModel,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final descriptionParts = transportationModel.description.split(" To ");
    final toLocation = descriptionParts.length > 1 ? descriptionParts[1] : "";

    final double fontSize =
        width < 400
            ? 14
            : width < 600
            ? 16
            : 18;
    final double priceFontSize =
        width < 400
            ? 20
            : width < 600
            ? 24
            : 28;
    final double padding = width < 400 ? 12 : 16;
    final double cardHeight =
        width < 400
            ? 280
            : width < 600
            ? 320
            : 360;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: cardHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                transportationModel.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[300]!, Colors.grey[400]!],
                      ),
                    ),
                    child: Center(
                      child: CircularProgressIndicator(
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                        color: const Color(0xFFFF5555),
                        strokeWidth: 3,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[400]!, Colors.blue[600]!],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_bus,
                            size: 60,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Transportation Service',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: padding,
                        vertical: padding * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        transportationModel.typeBus,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize + 2,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Spacer
                    const Spacer(),
                    // Bottom content
                    Column(
                      children: [
                        // Price
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: padding,
                            vertical: padding * 0.5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: const Color(0xFF2C2C2C),
                                  fontSize: priceFontSize,
                                  fontWeight: FontWeight.w800,
                                ),
                                children: [
                                  TextSpan(
                                    text: currency,
                                    style: TextStyle(
                                      fontSize: priceFontSize * 0.7,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: transportationModel.price.toString(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: padding),
                        // Description
                        Container(
                          padding: EdgeInsets.all(padding * 0.8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            transportationModel.description,
                            style: TextStyle(
                              fontSize: fontSize * 0.9,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: padding),
                        // Book Now Button
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFF5555),
                                const Color(0xFFFF3333),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF5555).withOpacity(0.4),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BlocProvider(
                                        create:
                                            (context) =>
                                                TransportationBookingCubit(
                                                  ApiService(Dio()),
                                                ),
                                        child: TransportBookingForm(
                                          transportationModel:
                                              transportationModel,
                                        ),
                                      ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: padding),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                fontSize: fontSize + 2,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tourist_website/core/network/api_service.dart';
// import 'package:tourist_website/features/transportation_Booking/data/models/transportation_model.dart';
// import 'package:tourist_website/features/transportation_Booking/presentation/manager/transportation_booking_cubit/transportation_booking_cubit.dart';
// import 'package:tourist_website/features/transportation_Booking/presentation/widgets/transportation_booking_form.dart';

// class TransportationBookingCard extends StatelessWidget {
//   final String title;
//   final String price;
//   final String currency;
//   final String fromLocation;
//   final String toLocation;
//   final TransportationModel transportationModel;
//   final double width;

//   const TransportationBookingCard({
//     super.key,
//     this.title = "Mini Bus 8 Pax",
//     this.price = "25",
//     this.currency = "\$",
//     this.fromLocation = "From Sharm el Sheikh Airport",
//     this.toLocation = "your hotel in sharm el sheikh",
//     required this.transportationModel,
//     required this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final descriptionParts = transportationModel.description.split(" To ");
//     final toLocation = descriptionParts.length > 1 ? descriptionParts[1] : "";

//     // Dynamic font size and padding based on card width
//     final double fontSize =
//         width < 400
//             ? 16
//             : width < 600
//             ? 18
//             : 22;
//     final double priceFontSize =
//         width < 400
//             ? 18
//             : width < 600
//             ? 24
//             : 32;
//     final double padding = width < 400 ? 12 : 16;

//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight:
//               width < 400
//                   ? 200
//                   : width < 600
//                   ? 240
//                   : 280, // Adjust height based on screen size
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min, // Allow card to size based on content
//           mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
//           children: [
//             // Header
//             Container(
//               padding: EdgeInsets.all(padding),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2C2C2C),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 transportationModel.typeBus,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: fontSize,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 textAlign: TextAlign.center,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             // Content
//             Padding(
//               padding: EdgeInsets.all(padding),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Price
//                   FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: RichText(
//                       text: TextSpan(
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: priceFontSize,
//                           fontWeight: FontWeight.w300,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: currency,
//                             style: TextStyle(fontSize: priceFontSize * 0.7),
//                           ),
//                           TextSpan(text: transportationModel.price.toString()),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: padding),
//                   // Full Description
//                   Text(
//                     transportationModel.description,
//                     style: TextStyle(
//                       fontSize: fontSize * 0.8,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             // Book Now Button (takes remaining space at bottom)
//             Padding(
//               padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder:
//                             (context) => BlocProvider(
//                               create:
//                                   (context) => TransportationBookingCubit(
//                                     ApiService(Dio()),
//                                   ),
//                               child: TransportBookingForm(
//                                 transportationModel: transportationModel,
//                               ),
//                             ),
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFF5555),
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: padding * 0.8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     "Book Now",
//                     style: TextStyle(
//                       fontSize: fontSize * 0.9,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
