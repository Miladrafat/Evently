import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/providers/UserProvider.dart';
import 'package:evently_c18/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c18/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently_c18/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_c18/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 0;
  List<Widget> tabs =[
    HomeTab(),
    FavoriteTab(),
    ProfileTab()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      var MyuserProvider=Provider.of<Userprovider>(context,listen: false);
      MyuserProvider.fetchuser();
    },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddEventScreen.routeName);
          },
        child: SvgPicture.asset(AssetsManager.add),
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: selected,
          onDestinationSelected: (value) {
            selected = value;
            setState(() {

            });
          },
          destinations: [
            NavigationDestination(
                selectedIcon: SvgPicture.asset(AssetsManager.home_selected,colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn
                ),),
                icon: SvgPicture.asset(AssetsManager.home),
                label: StringsManager.home
            ),
            NavigationDestination(
                selectedIcon: SvgPicture.asset(AssetsManager.heart_selected,colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn
                ),),
                icon: SvgPicture.asset(AssetsManager.heart),
                label: StringsManager.favorite
            ),
            NavigationDestination(
                selectedIcon: SvgPicture.asset(AssetsManager.profile_selected,colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary, BlendMode.srcIn
                ),),
                icon: SvgPicture.asset(AssetsManager.profile),
                label: StringsManager.profile
            ),
          ]
      ),
      body: tabs[selected],
    );
  }
}
