import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/core/text_style.dart';
import 'package:deliverly/data/repository/pedidos_pendientes_repository.dart';
import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/pedidos_model.dart';
import 'package:deliverly/screens/verificacion_entrega_screens.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrincipalScreens extends StatefulWidget {
  const PrincipalScreens({super.key});

  @override
  State<PrincipalScreens> createState() => _PrincipalScreensState();
}

class _PrincipalScreensState extends State<PrincipalScreens> {
  late Future<List<PedidosModel>> _pedidosPendienteInfo;

  final ApiService apiService = ApiService();

  late PedidosPendientesRepository repository;

  @override
  void initState() {
    super.initState();

    repository = PedidosPendientesRepository(apiSer: apiService);

    _pedidosPendienteInfo = repository.getPedidosPendientes();
  }

  void recargar() {
    setState(() {
      _pedidosPendienteInfo = repository.getPedidosPendientes();
    });
  }

  Future<void> cambiarEstadoEnCamino(int idPedido) async {
    await apiService.post("pedidos_pendientes.php", {
      "action": "en_camino",
      "idPedido": idPedido.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Pedidos Pendientes", style: TextStyles.txtAppBar),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: recargar),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradientPedidos,
        ),
        child: FutureBuilder<List<PedidosModel>>(
          future: _pedidosPendienteInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No hay pedidos"));
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
                    borderRadius: BorderRadiusGeometry.circular(18),
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
                            const SizedBox(width: 15),
                            Expanded(child: Text(pedido.nombreCliente)),
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
                            const SizedBox(width: 15),
                            Expanded(child: Text(pedido.telefonoCliente)),
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
                            const SizedBox(width: 15),
                            Expanded(child: Text(pedido.direccion)),
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
                            const SizedBox(width: 15),
                            Expanded(child: Text(pedido.franjaCerrada)),
                          ],
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    trailing: Text(
                      formateoCadenas(pedido.estado),
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () async {
                      await cambiarEstadoEnCamino(pedido.id);
                      abrirMaps(pedido.direccion);
                      recargar();
                    },
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VerificacionEntregaScreens(idPedido: pedido.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Color getCardColor(String estado) {
    switch (estado) {
      case "en_camino":
        return Colors.orange.shade200;
      case "entregado":
        return Colors.green.shade200;
      default:
        return Colors.white; // pendiente
    }
  }

  String formateoCadenas(String estado) {
    switch (estado) {
      case "en_camino":
        return "En Camino";

      case "pendiente":
        return "Pendiente";

      case "entregado":
        return "Entregado";

      default:
        return estado;
    }
  }

  void abrirMaps(String direccion) async {
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(direccion)}",
    );
    //Para que lo abra directamente en google maps
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
