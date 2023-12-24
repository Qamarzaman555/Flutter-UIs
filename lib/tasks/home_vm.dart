import 'package:stacked/stacked.dart';

import 'person_model.dart';

class HomeVM extends BaseViewModel {
  bool isList = false;
  bool isDelete = false;
  List<Person> persons = [
    Person('Qamar', 'Intern', 15),
    Person('Sayad', 'Intern', 25),
    Person('Shahzain', 'Computer Engineer', 65),
    Person('Faraz', 'sr. developer', 140),
  ];

  onChangeView(bool value) {
    isList = value;
    notifyListeners();
  }

  onShowDeleteOpt() {
    isDelete = !isDelete;
    notifyListeners();
  }

  onDeletePerson(Person person) {
    persons.remove(person);
    notifyListeners();
  }
}
