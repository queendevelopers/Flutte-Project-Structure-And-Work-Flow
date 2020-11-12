import 'package:entry_assignment/core/viewmodels/basemodel.dart';
import 'package:entry_assignment/ui/github.dart';
import 'package:entry_assignment/ui/movies.dart';
import 'package:entry_assignment/ui/news.dart';
import 'package:entry_assignment/ui/resturant.dart';

class HomeModel extends BaseModel{
  int _selectedItem=0;
  int get selectedItem => _selectedItem;
  List currentTab=[News(),Movies(),Resturant(),GitHub()];

  set selectedItem(int index) {
    _selectedItem = index;
    notifyListeners();
  }
}