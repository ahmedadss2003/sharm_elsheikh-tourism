// import 'package:flutter/material.dart';
// import 'package:tourist_website/core/models/tour_model.dart';
// import 'package:tourist_website/features/place_detials/presentation/views/place_details_view.dart';

// class BesSalleAndMostPopularCard extends StatelessWidget {
//   final TourModel tourModel;
//   const BesSalleAndMostPopularCard({
//     super.key,
//     required this.index,
//     required this.tourModel,
//   });

//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     List<String> tourImages = [
//       'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1544551763-46a013bb70d5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//       'https://images.unsplash.com/photo-1559827260-dc66d52bef19?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
//     ];

//     List<String> tourTitles = [
//       'Ras Mohamed National Park Day Tour',
//       'Blue Lagoon',
//       'Snorkeling Catamarans in Blue Hole',
//       'Quad bike desert safari',
//       'Ras Mohamed National Park Day Tour',
//       'Blue Lagoon',
//       'Snorkeling Catamarans in Blue Hole',
//       'Quad bike desert safari',
//       'Ras Mohamed National Park Day Tour',
//       'Blue Lagoon',
//       'Snorkeling Catamarans in Blue Hole',
//       'Quad bike desert safari',
//       'Ras Mohamed National Park Day Tour',
//       'Blue Lagoon',
//       'Snorkeling Catamarans in Blue Hole',
//       'Quad bike desert safari',
//     ];

//     return LayoutBuilder(
//       builder: (context, constrains) {
//         return GestureDetector(
//           onTap: () {
//             print(tourModel.images[0].image);
//             Navigator.pushNamed(
//               context,
//               PlaceDetailsView.routeName,
//               arguments: tourModel,
//             );
//           },
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: constrains.maxWidth,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(10),
//                           ),
//                           image: DecorationImage(
//                             image: NetworkImage(tourModel.images[0].image),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 3,
//                       child: Padding(
//                         padding: EdgeInsets.all(12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Flexible(
//                               child: Text(
//                                 tourModel.title,

//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Row(
//                               children: List.generate(5, (index) {
//                                 return Icon(
//                                   Icons.star,
//                                   color:
//                                       index < 4
//                                           ? Colors.amber
//                                           : Colors.grey[300],
//                                   size: 16,
//                                 );
//                               }),
//                             ),
//                             SizedBox(height: 12),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 45, 154, 85),
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                   left: 6.0,
//                                   right: 20,
//                                   top: 3,
//                                   bottom: 3,
//                                 ),
//                                 child: Text(
//                                   "\$${tourModel.priceAdult.toString()}",
//                                   style: TextStyle(
//                                     color: const Color.fromARGB(
//                                       255,
//                                       255,
//                                       255,
//                                       255,
//                                     ),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Positioned(
//               //   top: 10,
//               //   left: -20,
//               //   child: Transform.rotate(
//               //     angle: -0.785398,
//               //     child: Container(
//               //       width: 120,
//               //       padding: const EdgeInsets.symmetric(vertical: 4),
//               //       color: Colors.red[700],
//               //       child: Center(
//               //         child: Text(
//               //           "tourModel status",
//               //           style: TextStyle(
//               //             color: Colors.white,
//               //             fontWeight: FontWeight.bold,
//               //             fontSize: 12,
//               //             letterSpacing: 1,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
