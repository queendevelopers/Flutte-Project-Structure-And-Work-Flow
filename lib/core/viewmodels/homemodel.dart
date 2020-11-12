import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/ui/views/github.dart';
import 'package:entry_assignment/ui/views/movies.dart';
import 'package:entry_assignment/ui/views/news.dart';
import 'package:entry_assignment/ui/views/resturant.dart';


class HomeModel extends BaseModel{
  int _selectedItem=0;
  int get selectedItem => _selectedItem;
  List currentTab=[News(),Movies(),Resturant(),GitHub()];

  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }
}