import 'package:flutter/material.dart';
import 'package:yonsei_financial_tech/pages/education/education.dart';
// pages
import 'package:yonsei_financial_tech/pages/people/people.dart';
import 'package:yonsei_financial_tech/pages/home/home.dart';
import 'package:yonsei_financial_tech/pages/project/project.dart';
import 'package:yonsei_financial_tech/pages/publication/publication.dart';
import 'package:yonsei_financial_tech/pages/working_paper/working_paper.dart';
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
          BouncingScrollWrapper.builder(context, widget),
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
            case Routes.education:
              return EduPage();
            case Routes.people:
              return PeoplePage();
            case Routes.project:
              return ProjectPage();
            case Routes.paper:
              return PaperPage();
            case Routes.publish:
              return PublishPage();
            default:
              return SizedBox.shrink();
          }
        });
      },
      // theme: Theme.of(context).copyWith(platform: TargetPlatform.macOS),
      theme: ThemeData(
        fontFamily: 'Yonsei'
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
