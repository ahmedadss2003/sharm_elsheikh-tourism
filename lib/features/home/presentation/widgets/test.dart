// import 'package:flutter/material.dart';
// import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String description = 'Your description text here'; // Replace with your actual description
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Enhanced Expanded Tile'),
//           backgroundColor: Color(0xFF1a73e8),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: ExpandedTileList(
//             children: [
//               ExpandedTile(
//                 title: Text(
//                   'Description',
//                   style: TextStyle(
//                     color: Color(0xFF1a73e8),
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 content: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xFF1a73e8).withOpacity(0.1),
//                         Color(0xFF1a73e8).withOpacity(0.3),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12.0),
//                     border: Border.all(
//                       color: Colors.grey[300]!,
//                       width: 1.0,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.all(16.0), // Added padding for content
//                   child: Text(
//                     description,
//                     style: TextStyle(
//                       fontSize: 14,
//                       height: 1.5,
//                       color: Colors.grey[800],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 controller: ExpandedTileController(),
//                 leading: Icon(
//                   Icons.description,
//                   size: 24,
//                   color: Color(0xFF1a73e8),
//                 ),
//                 trailing: AnimatedBuilder(
//                   animation: ExpandedTileController(),
//                   builder: (context, child) {
//                     return Transform.rotate(
//                       angle: ExpandedTileController().isExpanded ? 3.14 : 0,
//                       child: Icon(
//                         Icons.arrow_drop_down,
//                         color: Color(0xFF1a73e8),
//                         size: 24,
//                       ),
//                     );
//                   },
//                 ),
//                 border: Border.all(
//                   color: Color(0xFF1a73e8).withOpacity(0.5),
//                   width: 1.0,
//                 ),
//                 borderRadius: BorderRadius.circular(10.0),
//                 onTap: () {
//                   // Handle tap event
//                   print('Tile tapped!');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }