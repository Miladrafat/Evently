import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/resources/my_flutter_app_icons.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/all_view.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/birhtday_view.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/book_view.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/exhibition_view.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/meeting_view.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/widgets/sport_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          length: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24,
            children: [
              Column(
                children: [
                  Text("Welcome Back ✨",style: Theme.of(context).textTheme.labelSmall,),
                  Text("John Safwat",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              TabBar(
                onTap: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
                tabAlignment: TabAlignment.start,
                dividerHeight: 0,
                  labelColor: Colors.white,
                  unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tabs: [
                    Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(MyFlutterApp.all,size: 24,),
                          Text(StringsManager.all)
                        ],
                      ),
                    ),
                ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),

                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(MyFlutterApp.bike,size: 24,),

                            Text(StringsManager.sport)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(16),

                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(MyFlutterApp.birthday_icon,size: 24,),

                            Text(StringsManager.birthday)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(16),

                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(MyFlutterApp.book,size: 24,),

                            Text(StringsManager.bookClub)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(16),

                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(MyFlutterApp.exhibition,size: 24,),

                            Text(StringsManager.exhibition)
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),

                        ),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(MyFlutterApp.meeting,size: 24,),

                            Text(StringsManager.meeting)
                          ],
                        ),
                      ),
                    ),
              ]),
              Expanded(
                child: TabBarView(
                    children: [
                      AllView(),
                      SportView(),
                      BirthdayView(),
                      BookView(),
                      ExhibitionView(),
                      MeetingView()
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
