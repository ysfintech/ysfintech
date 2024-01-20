import 'package:js/js.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yonsei_financial_tech/pages/extendable_board.dart';

// pages
import 'package:yonsei_financial_tech/pages/people/people.dart';
import 'package:yonsei_financial_tech/pages/home/home.dart';
import 'package:yonsei_financial_tech/pages/project/project.dart';
import 'package:yonsei_financial_tech/pages/publication/publication.dart';

// routes
import './routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            Breakpoint(start: 0, end: 360, name: 'SMALL_MOBILE'),
            Breakpoint(start: 361, end: 450, name: MOBILE),
            Breakpoint(start: 451, end: 800, name: TABLET),
            Breakpoint(start: 801, end: 1920, name: DESKTOP),
            Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
      ),
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
      title: '연세대학교 금융기술센터',
    );
  }
}
