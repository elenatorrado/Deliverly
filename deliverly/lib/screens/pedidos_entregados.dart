import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/core/text_style.dart';
import 'package:deliverly/data/repository/pedidos_entregados.dart';
import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/pedidos_model.dart';
import 'package:flutter/material.dart';

class PedidosEntregados extends StatefulWidget {
  const PedidosEntregados({super.key});

  @override
  State<PedidosEntregados> createState() => _PedidosEntregadosState();
}

class _PedidosEntregadosState extends State<PedidosEntregados> {
  //Inicializamos la variable que nos devolvera los datos
  late Future<List<PedidosModel>> _pedidosEntregados;
  //Creamos el objeto del repositorio
  final ApiService apiService = ApiService();
  //Indicamos el repositorio de pedidos entregados
  late PedidosEntregadosRepository repository;

  //Carga los pedidos nada mas abrir la pantalla
  @override
  void initState() {
    super.initState();
    repository = PedidosEntregadosRepository(apiSer: apiService);

    _pedidosEntregados = repository.getPedidosEntregados();
  }

  void recargar() {
    setState(() {
      _pedidosEntregados = repository.getPedidosEntregados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Pedidos Entregados", style: TextStyles.txtAppBar),
        actions: [
          IconButton(onPressed: recargar, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradientPedidos,
        ),
        child: FutureBuilder<List<PedidosModel>>(
          future: _pedidosEntregados,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text("No hay datos", style: TextStyles.body),
              );
            }
            final pedidos = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return Card(
                  color: getCardColor(pedido.estado),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blueGrey,
                  child: ListTile(
                    title: Text(
                      "Pedido #${pedido.id}",
                      style: TextStyles.titulosCard,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/persona.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                pedido.nombreCliente,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/telefono.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                pedido.telefonoCliente,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/casa.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                pedido.direccion,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),

                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/reloj.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                pedido.franjaCerrada,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    trailing: Text(
                      formateoCadenas(pedido.estado),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String formateoCadenas(String estado) {
    if (estado == "entregado") {
      return "Entregado";
    }
    return estado;
  }

  Color getCardColor(String estado) {
    if (estado == "entregado") {
      return Colors.greenAccent;
    }

    return Colors.white;
  }
}
