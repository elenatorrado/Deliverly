import 'package:deliverly/core/app_colors.dart';
import 'package:pinput/pinput.dart';
import 'package:deliverly/data/repository/verificar_codigo_repository.dart';
import 'package:deliverly/data/services/api_services.dart';
import 'package:flutter/material.dart';

class VerificacionEntregaScreens extends StatefulWidget {
  final int idPedido;

  const VerificacionEntregaScreens({super.key, required this.idPedido});

  @override
  State<VerificacionEntregaScreens> createState() =>
      _VerificacionEntregaScreensState();
}

class _VerificacionEntregaScreensState
    extends State<VerificacionEntregaScreens> {
  //La Conexion con nuestra API
  ApiService api = ApiService();
  //La conexion con nuestro REPO
  late VerificarCodigoRepository repository;
  //Controller para que se coja el texto que introducimos
  final TextEditingController codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    repository = VerificarCodigoRepository(api: api);
  }

  void validarCodigo() async {
    final codigo = codigoController.text;

    final ok = await repository.verificarCodigo(widget.idPedido, codigo);

    if (ok) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Correcto"),
          content: Text("Pedido entregado"),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Código incorrecto"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaPin = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white38),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrega Pedido"),
        backgroundColor: AppColors.secondary,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradientPedidos,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Introduzca el codigo de verificacion que le ha dado el cliente",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),
            Pinput(
              length: 6,
              controller: codigoController,
              //Caja seleccionada por defecto
              defaultPinTheme: temaPin,
              //Caja seleccionada
              focusedPinTheme: temaPin.copyWith(
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
              //Caja rellenada con numero
              submittedPinTheme: temaPin.copyWith(
                decoration: BoxDecoration(
                  color: AppColors.primary, // rojo al rellenar
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary),
                ),
              ),
              onCompleted: (codigo) {
                validarCodigo();
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: validarCodigo,
              child: Text("Validar entrega"),
            ),
          ],
        ),
      ),
    );
  }
}
