import 'package:flutter/material.dart';
import 'package:flutter_app1/modules/shop/cubit/cubit.dart';
import 'package:flutter_app1/modules/shop/cubit/states.dart';
import 'package:flutter_app1/modules/shop/login/login-page.dart';
import 'package:flutter_app1/modules/shop/search/search_screen.dart';
import 'package:flutter_app1/shared/component/component.dart';
import 'package:flutter_app1/shared/network/cacheHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Souq',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (index) {
              cubit.ChangeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'Categories', icon: Icon(Icons.apps)),
              BottomNavigationBarItem(
                  label: 'Favorite', icon: Icon(Icons.favorite)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings)),
            ],
          ),
        );
      },
    );
  }
}
