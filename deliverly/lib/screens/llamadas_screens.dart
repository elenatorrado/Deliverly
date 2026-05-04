import 'package:deliverly/core/app_colors.dart';
import 'package:deliverly/core/text_style.dart';
import 'package:deliverly/data/repository/llamada_repository.dart';
import 'package:deliverly/data/services/api_services.dart';
import 'package:deliverly/models/llamadas_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LlamadasScreens extends StatefulWidget {
  const LlamadasScreens({super.key});

  @override
  State<LlamadasScreens> createState() => _LlamadasScreensState();
}

class _LlamadasScreensState extends State<LlamadasScreens> {
  //Lista donde guardamos los datos desde el servidor
  late Future<List<LlamadasModel>> _llamadasInfo;
  //Api Service para conectar con PHP
  ApiService apiServ = ApiService();
  //Repository para que actue entre la API Y FLUTTER
  late LlamadaRepository repository;

  @override
  void initState() {
    super.initState();
    //Aqui indicamos que utilice el repositorio para conectar con PHP
    repository = LlamadaRepository(apiSer: apiServ);
    //Aqui Flutter le pide los datos a nuestro repository y lo convierte en la lista
    _llamadasInfo = repository.getLlamadas();
  }

  void recargar() {
    setState(() {
      //Vuelve a pedir datos y refresca la pantalla
      _llamadasInfo = repository.getLlamadas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Llamadas", style: TextStyles.txtAppBar),
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
        child: FutureBuilder<List<LlamadasModel>>(
          future: _llamadasInfo,
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
            //Creamos la variable que contendra todos los datos
            final llamada = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: llamada.length,
              itemBuilder: (context, index) {
                final llamadas = llamada[index];
                return Card(
                  color: AppColors.secondary,
                  margin: EdgeInsets.only(bottom: 12),
                  elevation: 5,
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "Pedido #${llamadas.id}",
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
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                llamadas.nombreCliente,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/telefono.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                llamadas.telefonoCliente,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/casa.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                llamadas.direccion,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/reloj.png",
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                llamadas.franjaHorario,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    trailing: Text(
                      formateocadena(llamadas.estado),
                      style: TextStyles.body,
                    ),
                    onTap: () {
                      hacerLlamada(llamadas.telefonoCliente);
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

  String formateocadena(String estado) {
    if (estado == "pendiente") {
      return "Pendiente";
    }
    return estado;
  }

  void hacerLlamada(String telefonoCliente) async {
    final url = Uri.parse("tel:${telefonoCliente}");
    //Para que lo abra directamente en google maps
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
