import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/pages/extendable_board.dart';

// pages
import 'package:yonsei_financial_tech/pages/people/people.dart';
import 'package:yonsei_financial_tech/pages/home/home.dart';
import 'package:yonsei_financial_tech/pages/project/project.dart';
import 'package:yonsei_financial_tech/pages/publication/publication.dart';
// import 'package:yonsei_financial_tech/pages/working_paper/working_paper.dart';
// import 'package:yonsei_financial_tech/pages/worklist/worklist.dart';
// import 'package:yonsei_financial_tech/pages/seminar/seminar.dart';
// routes
import './routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget ?? this) ,
          maxWidth: double.infinity,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Colors.white)),
      initialRoute: Routes.home,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case Routes.home:
              return HomePage();
            case Routes.people:
              return PeoplePage();
            case Routes.project:
              return ProjectPage();
            case Routes.paper:
              return ExtendablePage('paper');
            case Routes.publish:
              return PublishPage();
            case Routes.work:
              return ExtendablePage('work');
            case Routes.seminar:
              return ExtendablePage('seminar');
            case Routes.conference:
              return ExtendablePage('conference');
            default:
              return SizedBox.shrink();
          }
        });
      },
      // theme: Theme.of(context).copyWith(platform: TargetPlatform.macOS),
      theme: ThemeData(fontFamily: GoogleFonts.nunito().fontFamily),
      debugShowCheckedModeBanner: false,
      title: '??????????????? ??????????????????',
    );
  }
}

