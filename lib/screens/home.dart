import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/screens/address/address.dart';
import 'package:legiao_bebidas_app/screens/products/products.dart';
import 'package:legiao_bebidas_app/widgets/cart_fab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: const CartFab(),
        body: IndexedStack(
          index: currentIndex,
          children: [
            const ProductsScreen(),
            const AddressScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) => setState(() {
            currentIndex = newIndex;
          }),
          currentIndex: currentIndex,
          showUnselectedLabels: true,
          selectedItemColor: Palette.primary,
          unselectedItemColor: Colors.white,
          backgroundColor: Palette.lightBlack,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Palette.lightBlack,
              icon: Icon(FontAwesomeIcons.beer),
              label: 'Produtos',
            ),
            BottomNavigationBarItem(
              backgroundColor: Palette.lightBlack,
              icon: Icon(Icons.location_on),
              label: 'Endereço',
            ),
          ],
        ),
      );
}
