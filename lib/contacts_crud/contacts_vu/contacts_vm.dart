import 'package:stacked/stacked.dart';

import '../con_model/con_model.dart';

class ContactsVM extends BaseViewModel {
  List<ContactsModel> searchedContacts = [];

  List<ContactsModel> contacts = [
    ContactsModel(
      firstName: 'Abdullah',
      lastName: 'Mangol',
      phone: 92333333333,
      sim: 'Sim 1',
    ),
    ContactsModel(
      firstName: 'Sayad',
      phone: 92333333333,
      lastName: 'Afridi',
      sim: 'Sim 1',
    ),
    ContactsModel(
      firstName: 'Fahad',
      phone: 92333333333,
      lastName: 'Afridi',
      sim: 'Sim 2',
    ),
    ContactsModel(
      firstName: 'Ihsan',
      phone: 92333333333,
      lastName: 'Afridi',
      sim: 'Sim 1',
    ),
    ContactsModel(
      firstName: 'Yaseen',
      phone: 92333333333,
      lastName: 'Afridi',
      sim: 'Sim 2',
    ),
  ];

  onDeleteContact(ContactsModel contact) {
    contacts.remove(contact);
    searchedContacts.remove(contact);
    notifyListeners();
  }

  onAddContact(contact) {
    contacts.add(contact);
    notifyListeners();
  }

  onUpdateContact(int index, ContactsModel contact) {
    contacts[index] = contact;
    notifyListeners();
  }

  onSearchContacts(String? search) {
    if (search != null && search.isNotEmpty) {
      searchedContacts = contacts
          .where(
            (contact) =>
                contact.firstName
                    .toLowerCase()
                    .contains(search.toLowerCase()) ||
                contact.lastName.toLowerCase().contains(search.toLowerCase()),
          )
          .toList();
    } else {
      searchedContacts.clear();
    }
    notifyListeners();
  }
}
