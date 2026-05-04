import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/screens/llamadas_screens.dart';
import 'package:deliverly/screens/pedidos_entregados.dart';
import 'package:deliverly/screens/principal_screens.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _itemSeleccionado = 0;

  final List<Widget> _listaPantallas = [
    PrincipalScreens(),
    PedidosEntregados(),
    LlamadasScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listaPantallas[_itemSeleccionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _itemSeleccionado,
        backgroundColor: AppColors.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: (indice) {
          setState(() {
            _itemSeleccionado = indice;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/pendiente.png")),
            label: "Pendientes",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/entregado.png")),
            label: "Entregados",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/telefono.png")),
            label: "Llamadas",
          ),
        ],
      ),
    );
  }
}
