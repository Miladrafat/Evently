import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c18/core/remote/network/Firestoremanager.dart';
import 'package:evently_c18/core/resources/AssetsManager.dart';
import 'package:evently_c18/core/resources/StringsManager.dart';
import 'package:evently_c18/core/reusable_components/custom_btn.dart';
import 'package:evently_c18/core/reusable_components/custom_field.dart';
import 'package:evently_c18/model/event.dart';
import 'package:evently_c18/ui/add_event/widgets/image_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/AppConstants.dart';
import '../../../core/resources/dialog_utiles.dart';
import '../../../core/resources/my_flutter_app_icons.dart';
import '../../../core/reusable_components/back_btn.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add_event";
  final Event? event;

  const AddEventScreen({super.key, this.event});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    // If event provided => editing mode, prefill fields
    if (widget.event != null) {
      titleController.text = widget.event!.title ?? '';
      descController.text = widget.event!.desc ?? '';
      // set selected tab based on type if exists
      if (widget.event!.type != null) {
        final index = AppConstants.EventType.indexOf(widget.event!.type!);
        if (index >= 0) selectedTab = index;
      }
      if (widget.event!.dateAndTime != null) {
        newDate = widget.event!.dateAndTime!.toDate();
        newTime = TimeOfDay.fromDateTime(newDate!);
      }
    }
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.25,
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ImageTabView(imagePath: AppConstants.getEventImage("Sport", Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark)),
                          ImageTabView(imagePath: AppConstants.getEventImage("birthday", Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark)),
                          ImageTabView(imagePath: AppConstants.getEventImage("book club", Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark)),
                          ImageTabView(imagePath: AppConstants.getEventImage("Exhibition", Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark)),
                          ImageTabView(imagePath: AppConstants.getEventImage("Meeting", Theme.of(context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark)),
                        ],
                      ),
                    ),
                    TabBar(
                      onTap: (value) {
                        selectedTab = value;
                      },
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
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          StringsManager.eventDate,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            chooseEventdate();
                          },
                          child: Text(
                            newDate == null
                                ? "choose date"
                                : DateFormat.yMd().format(newDate!),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
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
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          StringsManager.eventTime,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            chooseEventTime();
                          },
                          child: Text(
                            newTime == null
                                ? "choose date"
                                : "${newTime?.hour}:${newTime?.minute}:${newTime?.period.name}",
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomBtn(
                        title: widget.event == null ? StringsManager.addEvent : 'Update Event',
                        onClick: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            if (newTime==null || newDate==null){
                              DialogUtiles.showToastmessage(context,"Choose Event Date and Time");

                            }
                            else{
                              DialogUtiles.showloadingdialog(context);
                              try {
                                final currentUserId = FirebaseAuth.instance.currentUser!.uid;
                                if (widget.event != null && widget.event!.userid != currentUserId) {
                                  Navigator.of(context, rootNavigator: true).pop();
                                  DialogUtiles.showMessagedialog(context, 'Only the event owner can update this event.');
                                  return;
                                }

                                final ev = Event(
                                  title: titleController.text,
                                  desc: descController.text,
                                  userid: currentUserId,
                                  type: AppConstants.EventType[selectedTab],
                                  dateAndTime: Timestamp.fromDate(
                                    DateTime(
                                      newDate!.year,
                                      newDate!.month,
                                      newDate!.day,
                                      newTime!.hour,
                                      newTime!.minute,
                                    ),
                                  ),
                                  id: widget.event?.id,
                                );

                                if (widget.event == null) {
                                  await Firestoremanager.addEvent(ev);
                                  // close loading dialog
                                  Navigator.of(context, rootNavigator: true).pop();
                                  DialogUtiles.showToastmessage(context,"Event Added Sucessfully");
                                  // go back to previous screen
                                  Navigator.of(context).pop();
                                } else {
                                  await Firestoremanager.updateEvent(ev);
                                  // try to propagate the updated event to users' favourites (best-effort)
                                  try {
                                    await Firestoremanager.propagateEventUpdate(ev);
                                  } catch (e) {
                                    // propagation failed (likely security rules) - log and continue
                                    print('Propagation failed: $e');
                                  }
                                  Navigator.of(context, rootNavigator: true).pop();
                                  DialogUtiles.showToastmessage(context,"Event Updated Sucessfully");
                                  Navigator.of(context).pop();
                                }
                              } catch (e) {
                                // ensure loading dialog closed
                                try { Navigator.of(context, rootNavigator: true).pop(); } catch (_) {}
                                DialogUtiles.showMessagedialog(context, 'Operation failed: ${e.toString()}');
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? newDate;

  chooseEventdate() async {
    newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: newDate,
    );
    if (newDate != null) {
      setState(() {});
    }
  }

  TimeOfDay? newTime;

  chooseEventTime() async {
    newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {});
    }
  }
}

Future<void> deleteEvent

(String eventId, String userId) async
{

final user = FirebaseAuth.instance.currentUser;if (
user == null) {
throw Exception('User not authenticated');
}
if (userId != user.uid) {
throw Exception('You are not the owner of this event');
}
await FirebaseFirestore.instance
    .collection('events')
    .doc(eventId)
    .delete();
}
