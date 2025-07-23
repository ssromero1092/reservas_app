import 'package:flutter/material.dart';

Future<void> confirmDialog(
  BuildContext context,
  String titulo,
  String subtitulo, {
  void Function()? onConfirm,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            titulo,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //fontFamily: 'Nunito',
            ),
          ),
          content: Text(
            subtitulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              //fontFamily: 'Nunito',
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onConfirm != null) onConfirm();
              },
              child: const Text('Confirmar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        ),
  );
}

Future<void> alerDialog(BuildContext context, String titulo, String subtitulo) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            titulo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              //fontFamily: 'Nunito',
            ),
          ),
          content: Text(
            subtitulo,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              //fontFamily: 'Nunito',
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MaterialButton(
              elevation: 5,
              textColor: Colors.blueAccent,
              onPressed: () => Navigator.pop(context),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Entiendo',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    //fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}
