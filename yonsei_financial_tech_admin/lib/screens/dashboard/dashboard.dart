// import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   bool loading = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(MediaQuery.of(context).size.height);
//     return CustomScrollView(
//       slivers: <Widget>[
//         SliverList(
//           delegate: SliverChildListDelegate([
//             Container(
//               margin: EdgeInsets.only(top: 12),
//               child: Column(
//                 children: <Widget>[
//                   MediaQuery.of(context).size.width < 1300
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: List<Widget>.generate(4, (i) {
//                             return Container(color: Colors.red,);
//                           }),
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: List<Widget>.generate(4, (i) {
//                             return Container(color: Colors.red,);
//                           })),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   loading
//                       ? Container(color: Colors.red,)
//                       : Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                 ],
//               ),
//             ),
//           ]),
//         ),
//       ],
//     );
//   }
// }
