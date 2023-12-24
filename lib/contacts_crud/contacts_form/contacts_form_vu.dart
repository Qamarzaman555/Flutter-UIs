import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';
import 'package:stacked/stacked.dart';

import 'contacts_form_vm.dart';
import '../con_model/con_model.dart';

class ContactsFromVU extends StackedView<ContactsFromVM> {
  const ContactsFromVU({this.contact, this.forUpdate = false, super.key});
  final ContactsModel? contact;
  final bool forUpdate;

  @override
  Widget builder(
      BuildContext context, ContactsFromVM viewModel, Widget? child) {
    return Scaffold(
      appBar: _customAppBar(context, viewModel, forUpdate),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blue.shade200,
              height: MediaQuery.sizeOf(context).height / 4,
              width: MediaQuery.sizeOf(context).width,
              child: const Icon(
                Icons.person_outline,
                size: 200,
                color: Colors.white24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: contactDetailsForm(viewModel, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactDetailsForm(ContactsFromVM viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      child: Column(
        children: [
          CHIDropDownBottomSheet(
            selectedIndex: viewModel.selectedIndex,
            title: 'Select Sim',
            items: viewModel.sims,
            onTap: (i) {
              viewModel.onSelectSim(context, i);
            },
          ),
          20.spaceY,
          contactNameFields(viewModel),
          contactPhoneField(viewModel),
        ],
      ),
    );
  }

  Widget contactPhoneField(ContactsFromVM viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12, right: 16),
          child: Icon(
            Icons.phone_outlined,
            size: 32,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "phone",
                ),
                initialValue: contact?.phone.toString(),
                keyboardType: TextInputType.phone,
                validator: viewModel.phoneValidator,
                onSaved: viewModel.onPhoneSaved,
              ),
              20.spaceY,
            ],
          ),
        ),
      ],
    );
  }

  Widget contactNameFields(ContactsFromVM viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12, right: 16),
          child: Icon(
            Icons.person_outline,
            size: 32,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "First Name",
                ),
                initialValue: contact?.firstName,
                validator: viewModel.firstNameValidator,
                onSaved: viewModel.onFirstNameSaved,
              ),
              20.spaceY,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
                initialValue: contact?.lastName,
                validator: viewModel.lastNameValidator,
                onSaved: viewModel.onLastNameSaved,
              ),
              20.spaceY,
            ],
          ),
        ),
      ],
    );
  }

  AppBar _customAppBar(
      BuildContext context, ContactsFromVM viewModel, bool forUpdate) {
    return AppBar(
      title: Text(
        'Edit Contact',
        style: CHIStyles.lgSemiBoldStyle,
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: () {
              viewModel.onSaveContact(context, forUpdate);
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  @override
  ContactsFromVM viewModelBuilder(BuildContext context) {
    return ContactsFromVM();
  }
}
