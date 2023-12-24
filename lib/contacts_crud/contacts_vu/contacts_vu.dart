// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:practice/contacts_crud/con_model/con_model.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import 'contact_details.dart';
import '../contacts_form/contacts_form_vu.dart';
import 'contacts_vm.dart';

class ContactsVU extends StackedView<ContactsVM> {
  ContactsVU({this.contact, super.key});
  ContactsModel? contact;

  @override
  Widget builder(BuildContext context, ContactsVM viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
      appBar: _customAppBar(context, viewModel),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.searchedContacts.isEmpty
              ? viewModel.contacts.length
              : viewModel.searchedContacts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 40, top: 12, bottom: 8, right: 4),
              child: contactsList(
                viewModel.searchedContacts.isEmpty
                    ? viewModel.contacts[index]
                    : viewModel.searchedContacts[index],
                context,
                viewModel,
                index,
              ),
            );
          },
        ),
      ),
      floatingActionButton: addContactButton(context, viewModel),
    ));
  }

  AppBar _customAppBar(BuildContext context, ContactsVM viewModel) {
    return AppBar(
      toolbarHeight: 70,
      centerTitle: true,
      elevation: 1,
      title: searchTextField(context, viewModel),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 4),
          child: Icon(
            Icons.more_vert,
            size: 28,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget searchTextField(BuildContext context, ContactsVM viewModel) {
    return TextFormField(
      onChanged: (value) {
        viewModel.onSearchContacts(value);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search_outlined,
          size: 20,
          color: Colors.grey,
        ),
        hintText: 'Search Contact',
        hintStyle: CHIStyles.smMediumStyle.copyWith(color: Colors.grey),
        suffixIcon: const Icon(
          Icons.mic_outlined,
          size: 20,
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(100)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(100)),
        filled: true,
        fillColor: Colors.blueGrey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
      ),
    );
  }

  Widget contactsList(
    ContactsModel contact,
    BuildContext context,
    ContactsVM viewModel,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (
          context,
        ) {
          return ContactsDetailsVU(
            contact: contact,
          );
        })).then((value) {
          if (value != null) {
            viewModel.onUpdateContact(index, value);
          }
        });
      },
      child: contactCell(contact, index, viewModel),
    );
  }

  Widget contactCell(ContactsModel contact, int index, ContactsVM viewModel) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundColor: Colors.pink.shade200,
              child: Text(
                contact.firstName.substring(0, 1).toCapitalized(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
              width: 15,
              child: CircleAvatar(
                child: Text(
                  contact.sim.substring(4, 5),
                  style: const TextStyle(fontSize: 8),
                ),
              ),
            ),
          ],
        ),
        24.spaceX,
        Expanded(
          child: Text(
            '${contact.firstName}\t${contact.lastName}',
            style: CHIStyles.mdMediumStyle,
          ),
        ),
        deleteContactBtn(viewModel, contact)
      ],
    );
  }

  Widget deleteContactBtn(ContactsVM viewModel, ContactsModel contact) {
    return IconButton(
      onPressed: () {
        viewModel.onDeleteContact(contact);
      },
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
    );
  }

  Widget addContactButton(BuildContext context, ContactsVM viewModel) {
    return FloatingActionButton(
      shape: const StadiumBorder(),
      backgroundColor: CHIStyles.primarySuccessColor,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ContactsFromVU();
            },
          ),
        ).then((value) {
          if (value != null) {
            viewModel.onAddContact(value);
          }
        });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  @override
  ContactsVM viewModelBuilder(BuildContext context) {
    return ContactsVM();
  }
}
