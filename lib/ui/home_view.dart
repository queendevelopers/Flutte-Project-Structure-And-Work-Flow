import 'package:entry_assignment/core/customcolors.dart';
import 'package:entry_assignment/core/viewmodels/customAppBar.dart';
import 'package:entry_assignment/core/viewmodels/homemodel.dart';
import 'package:entry_assignment/ui/routing.dart';
import 'package:entry_assignment/views/BaseView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model,
      builder: (context, homeModel, child) => Scaffold(
        appBar: CustomAppBar(
          title: 'Genius System',
          actionsItems: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Text('Settings'),
                ),
              ],
              onSelected: (index) {
                print(index);
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, Routing.settings_page);
                    break;
                }
              },
            )
          ],
        ),
        body: homeModel.currentTab[homeModel.selectedItem],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: CustomColors.primary_color,
          unselectedItemColor: Colors.grey,
          currentIndex: homeModel.selectedItem,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dynamic_feed),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_sharp),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Resturant',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.developer_board),
              label: 'GitHub',
            )
          ],
          onTap: (index) => homeModel.selectedItem = index,
        ),
      ),
    );
  }
}
