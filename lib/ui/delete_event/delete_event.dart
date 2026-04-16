import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently_c18/core/remote/network/Firestoremanager.dart';
import 'package:evently_c18/model/event.dart';
import 'package:evently_c18/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c18/core/resources/dialog_utiles.dart';

import '../../../core/resources/AppConstants.dart';

class DeleteEventScreen extends StatelessWidget {
  static const String routeName = '/delete_event';
  final Event event;

  const DeleteEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Event details'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Builder(
            builder: (ctx) {
              final currentUid = FirebaseAuth.instance.currentUser?.uid;
              final isOwner = currentUid != null && event.userid != null && currentUid == event.userid;

              if (isOwner) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddEventScreen(event: event)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                      onPressed: () => _onDeletePressed(context),
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Placeholder for image - user will provide asset path later
              Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset(
                    AppConstants.getEventImage(
                      event.type!,
                      Theme.of(context).brightness == Brightness.light
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(event.title ?? '', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _formatDate(event.dateAndTime),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('Description', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Text(event.desc ?? ''),
              ),
              SizedBox(height: 24),
              Builder(
                builder: (ctx) {
                  final currentUid = FirebaseAuth.instance.currentUser?.uid;
                  final isOwner = currentUid != null && event.userid != null && currentUid == event.userid;

                  if (isOwner) {
                    return ElevatedButton.icon(
                      icon: Icon(Icons.delete_outline),
                      label: Text('Delete event'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () => _onDeletePressed(context),
                    );
                  }
                  return SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(Timestamp? ts) {
    if (ts == null) return '';
    final dt = ts.toDate();
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
  }

  void _onDeletePressed(BuildContext context) async {
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUid == null) {
      DialogUtiles.showMessagedialog(context, 'You must be logged in to delete events.');
      return;
    }

    if (event.userid == null || event.userid != currentUid) {
      DialogUtiles.showMessagedialog(context, 'Only the event owner can delete this event.');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm delete'),
        content: Text('Are you sure you want to delete this event? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      DialogUtiles.showloadingdialog(context);

      await Firestoremanager.deleteEventAndCleanup(event.id!, userId: event.userid);

      Navigator.of(context, rootNavigator: true).pop();
      DialogUtiles.showToastmessage(context, 'Event deleted');

      Navigator.of(context).pop();
    } catch (e) {
      try {
        Navigator.of(context, rootNavigator: true).pop();
      } catch (_) {}
      DialogUtiles.showMessagedialog(context, 'Delete failed: ${e.toString()}');
    }
  }
}

