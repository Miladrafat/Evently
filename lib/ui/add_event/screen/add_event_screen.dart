import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import 'package:evently_c18/ui/add_event/widgets/image_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/my_flutter_app_icons.dart';
import '../../../core/reusable_components/back_btn.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add_event";

  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(StringsManager.addEvent), leading: BackBtn()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          length: 5,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: TabBarView(
                      children: [
                        ImageTabView(imagePath: AssetsManager.sport_light),
                        ImageTabView(imagePath: AssetsManager.birthday_light),
                        ImageTabView(imagePath: AssetsManager.book_light),
                        ImageTabView(imagePath: AssetsManager.exhibition_light),
                        ImageTabView(imagePath: AssetsManager.meeting_light),
                      ],
                    ),
                  ),
                  TabBar(
                    onTap: (value) {},
                    tabAlignment: TabAlignment.start,
                    dividerHeight: 0,
                    labelColor: Colors.white,
                    unselectedLabelColor: Theme.of(
                      context,
                    ).colorScheme.secondary,
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
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.bike, size: 24),

                              Text(StringsManager.sport),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.birthday_icon, size: 24),

                              Text(StringsManager.birthday),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.book, size: 24),

                              Text(StringsManager.bookClub),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.exhibition, size: 24),

                              Text(StringsManager.exhibition),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.meeting, size: 24),

                              Text(StringsManager.meeting),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        StringsManager.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      ),
                      CustomField(
                        controller: titleController,
                        hint: StringsManager.eventTitle,
                        prefixPath: "",
                        isEventAdd: true,
                        validation: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You should enter event title";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        StringsManager.desc,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                      ),
                      CustomField(
                        controller: descController,
                        hint: StringsManager.eventDesc,
                        prefixPath: "",
                        isEventAdd: true,
                        maxLines: 5,
                        validation: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You should enter event description";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.date,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn),
                      ),
                      SizedBox(width: 3,),
                      Text(StringsManager.eventDate,style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),
                      Spacer(),
                      TextButton(
                          onPressed: () {

                          }, child: Text(StringsManager.chooseDate,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400
                      ),))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.time,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.primary,
                            BlendMode.srcIn),
                      ),
                      SizedBox(width: 3,),
                      Text(StringsManager.eventTime,style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),
                      Spacer(),
                      TextButton(
                          onPressed: () {

                          }, child: Text(StringsManager.chooseTime,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400
                      ),))
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomBtn(title: StringsManager.addEvent, onClick: () {

                    },),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
