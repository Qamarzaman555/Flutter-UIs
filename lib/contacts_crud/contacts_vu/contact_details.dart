// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import '../contacts_form/contacts_form_vu.dart';
import '../con_model/con_model.dart';

class ContactsDetailsVU extends StatelessWidget {
  ContactsDetailsVU({required this.contact, super.key});
  ContactsModel contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(builder: (context, setState) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.blue.shade200,
                height: MediaQuery.sizeOf(context).height / 1.8,
                child: contactNameDetail(
                  context,
                  contact,
                  () {
                    CHIRouter.push(
                        context,
                        ContactsFromVU(
                          contact: contact,
                          forUpdate: true,
                        )).then((value) {
                      if (value != null) {
                        contact = value;
                        setState(
                          () {},
                        );
                        debugPrint('???????????????????${contact.firstName}');
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: phoneCard(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: phoneCard2(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: callRecorderCard(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget callRecorderCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              Icons.card_membership_outlined,
              color: Colors.blue,
            ),
            28.spaceX,
            const Expanded(
              child: Text('Call recorder'),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneCard2() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              Icons.video_camera_front,
              color: Colors.blue,
            ),
            28.spaceX,
            Expanded(
              child: Text(contact.phone.toString()),
            ),
            const Icon(
              Icons.video_camera_front,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Row(
          children: [
            const Icon(
              Icons.phone_outlined,
              color: Colors.blue,
            ),
            28.spaceX,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contact.phone.toString()),
                  2.spaceY,
                  const Text('Primary Number'),
                ],
              ),
            ),
            const Icon(
              Icons.chat_bubble_outline,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget contactNameDetail(
      BuildContext context, ContactsModel contact, void Function()? onTap) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12),
            child: contactNameInfo(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 44),
          child: contactEdit(context, contact, onTap),
        )
      ],
    );
  }

  Widget contactEdit(
      BuildContext context, ContactsModel contact, void Function()? onTap) {
    return Column(
      children: [
        Row(
          children: [
            editIconBtn(context, contact, onTap),
            4.spaceX,
            const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 28,
            ),
          ],
        )
      ],
    );
  }

  Widget editIconBtn(
      BuildContext context, ContactsModel contact, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
        size: 28,
      ),
    );
  }

  Widget contactNameInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 50, top: 80),
            child: Icon(
              Icons.person_outline,
              size: 250,
              color: Colors.white24,
            ),
          ),
        ),
        Text(
          '${contact.firstName}\t${contact.lastName}',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 32),
        ),
      ],
    );
  }
}
