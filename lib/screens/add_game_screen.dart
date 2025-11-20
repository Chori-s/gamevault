import 'package:flutter/material.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final tituloController = TextEditingController();

  // RadioListTile para plataforma
  String plataforma = 'PC';

  // CheckboxListTile para géneros
  final Map<String, bool> generos = {
    'Acción': false,
    'RPG': false,
    'Aventura': false,
    'Estrategia': false,
  };

  // Slider para calificación
  double calificacion = 5.0;

  // Switch para completado
  bool completado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir juego')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TÍTULO
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título del juego',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // PLATAFORMA
            const Text("Plataforma", style: TextStyle(fontSize: 16)),
            RadioListTile(
              title: const Text("PC"),
              value: "PC",
              groupValue: plataforma,
              onChanged: (value) => setState(() => plataforma = value!),
            ),
            RadioListTile(
              title: const Text("PS5"),
              value: "PS5",
              groupValue: plataforma,
              onChanged: (value) => setState(() => plataforma = value!),
            ),
            RadioListTile(
              title: const Text("Switch"),
              value: "Switch",
              groupValue: plataforma,
              onChanged: (value) => setState(() => plataforma = value!),
            ),

            const SizedBox(height: 25),

            // GÉNEROS
            const Text("Géneros", style: TextStyle(fontSize: 16)),
            ...generos.keys.map(
              (g) => CheckboxListTile(
                title: Text(g),
                value: generos[g],
                onChanged: (value) {
                  setState(() {
                    generos[g] = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 25),

            // SLIDER
            const Text("Calificación (0 - 10)", style: TextStyle(fontSize: 16)),
            Slider(
              value: calificacion,
              min: 0,
              max: 10,
              divisions: 20,
              label: calificacion.toStringAsFixed(1),
              onChanged: (value) {
                setState(() => calificacion = value);
              },
            ),

            const SizedBox(height: 25),

            // SWITCH
            SwitchListTile(
              title: const Text("Juego completado"),
              value: completado,
              onChanged: (value) {
                setState(() => completado = value);
              },
            ),

            const SizedBox(height: 40),

            // BOTÓN GUARDAR (con modal)
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final titulo = tituloController.text;

                  final generosSeleccionados = generos.entries
                      .where((e) => e.value)
                      .map((e) => e.key)
                      .toList();

                  await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Confirmación'),
                      content: Text('¿Guardar "$titulo"?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          child: const Text('Guardar'),
                          onPressed: () {
                            Navigator.pop(context); // cerrar dialogo

                            Navigator.pop(context, {
                              'titulo': titulo,
                              'plataforma': plataforma,
                              'generos': generosSeleccionados,
                              'calificacion': calificacion,
                              'completado': completado,
                            }); // enviar datos a HomeScreen
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Guardar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
