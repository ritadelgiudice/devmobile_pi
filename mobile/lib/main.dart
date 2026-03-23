import 'package:flutter/material.dart';
import 'dart:html' as html; // Importação para abrir links no Chrome

void main() {
  runApp(const MaterialApp(
    home: MinhaAgendaDelcon(),
    debugShowCheckedModeBanner: false,
  ));
}

class RegistroEntrega {
  final String destino;
  final String endereco;
  final String informacoes;

  RegistroEntrega({
    required this.destino, 
    required this.endereco, 
    required this.informacoes
  });
}

class MinhaAgendaDelcon extends StatefulWidget {
  const MinhaAgendaDelcon({super.key});

  @override
  State<MinhaAgendaDelcon> createState() => _MinhaAgendaDelconState();
}

class _MinhaAgendaDelconState extends State<MinhaAgendaDelcon> {
  final List<RegistroEntrega> _entregas = [];
  final TextEditingController _controleDestino = TextEditingController();
  final TextEditingController _controleEndereco = TextEditingController();
  final TextEditingController _controleInfo = TextEditingController();

  void _salvarRegistro() {
    setState(() {
      if (_controleDestino.text.isNotEmpty && _controleEndereco.text.isNotEmpty) {
        _entregas.add(
          RegistroEntrega(
            destino: _controleDestino.text,
            endereco: _controleEndereco.text,
            informacoes: _controleInfo.text,
          ),
        );
        _controleDestino.clear();
        _controleEndereco.clear();
        _controleInfo.clear();
      }
    });
  }

  // Função para abrir o endereço no Google Maps
  void _abrirNoMaps(String endereco) {
    final url = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(endereco)}';
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DELCON - Logística & Mapas'),
        backgroundColor: const Color(0xFF1A237E),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _controleDestino,
                      decoration: const InputDecoration(labelText: 'Nome do Destino/Cliente', prefixIcon: Icon(Icons.business)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controleEndereco,
                      decoration: const InputDecoration(labelText: 'Endereço Completo', prefixIcon: Icon(Icons.map)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controleInfo,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Observações da Carga', prefixIcon: Icon(Icons.list)),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _salvarRegistro,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), foregroundColor: Colors.white),
                        child: const Text('SALVAR NA AGENDA'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _entregas.length,
              itemBuilder: (context, index) {
                final entrega = _entregas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ExpansionTile(
                    leading: const Icon(Icons.local_shipping, color: Color(0xFF1A237E)),
                    title: Text(entrega.destino, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(entrega.endereco, maxLines: 1, overflow: TextOverflow.ellipsis),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('📝 Info: ${entrega.informacoes}'),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () => _abrirNoMaps(entrega.endereco),
                                  icon: const Icon(Icons.directions),
                                  label: const Text('VER NO MAPA'),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700], foregroundColor: Colors.white),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => setState(() => _entregas.removeAt(index)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}