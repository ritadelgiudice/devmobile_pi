import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:html' as html;

void main() {
  runApp(const MaterialApp(
    home: MinhaAgendaDelcon(),
    debugShowCheckedModeBanner: false,

    locale: Locale('pt', 'BR'),
    supportedLocales: [
      Locale('pt', 'BR'),
      Locale('en', 'US'),
    ],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
  ));
}

class RegistroEntrega {
  final String destino;
  final String endereco;
  final String informacoes;
  final DateTime dataInclusao;
  final DateTime dataEntrega;
  bool concluido;

  RegistroEntrega({
    required this.destino,
    required this.endereco,
    required this.informacoes,
    required this.dataInclusao,
    required this.dataEntrega,
    this.concluido = false,
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

  DateTime? _dataEntregaSelecionada;

  void _salvarRegistro() {
    if (_controleDestino.text.isNotEmpty &&
        _controleEndereco.text.isNotEmpty &&
        _dataEntregaSelecionada != null) {
      
      setState(() {
        _entregas.add(
          RegistroEntrega(
            destino: _controleDestino.text,
            endereco: _controleEndereco.text,
            informacoes: _controleInfo.text,
            dataInclusao: DateTime.now(),
            dataEntrega: _dataEntregaSelecionada!,
          ),
        );

        _controleDestino.clear();
        _controleEndereco.clear();
        _controleInfo.clear();
        _dataEntregaSelecionada = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos e selecione a data de entrega"),
        ),
      );
    }
  }

  Future<void> _selecionarDataEntrega() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dataEntregaSelecionada = picked;
      });
    }
  }

  void _abrirNoMaps(String endereco) {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(endereco)}';
    html.window.open(url, '_blank');
  }

  String _formatarData(DateTime data) {
    return "${data.day}/${data.month}/${data.year}";
  }

  Color _corStatus(RegistroEntrega entrega) {
    if (entrega.concluido) return Colors.green.shade100;

    if (entrega.dataEntrega.isBefore(DateTime.now())) {
      return Colors.red.shade100;
    }

    if (entrega.dataEntrega.difference(DateTime.now()).inDays <= 2) {
      return Colors.yellow.shade100;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DELCON - Trasnportadora'),
        backgroundColor:const Color.fromARGB(255, 66, 71, 127),
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
                      decoration: const InputDecoration(
                        labelText: 'Nome do Destino/Cliente',
                        prefixIcon: Icon(Icons.business),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controleEndereco,
                      decoration: const InputDecoration(
                        labelText: 'Endereço Completo',
                        prefixIcon: Icon(Icons.map),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controleInfo,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Observações da Carga',
                        prefixIcon: Icon(Icons.list),
                      ),
                    ),
                    const SizedBox(height: 10),

                    ElevatedButton.icon(
                      onPressed: _selecionarDataEntrega,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        _dataEntregaSelecionada == null
                            ? "Selecionar data de entrega"
                            : "Entrega: ${_formatarData(_dataEntregaSelecionada!)}",
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _salvarRegistro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 66, 71, 127),
                          foregroundColor: Colors.white,
                        ),
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
                  color: _corStatus(entrega),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ExpansionTile(
                    leading: const Icon(Icons.local_shipping,
                        color: Color(0xFF1A237E)),
                    title: Text(
                      entrega.destino,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: entrega.concluido
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      entrega.endereco,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('📅 Inclusão: ${_formatarData(entrega.dataInclusao)}'),
                            Text('🚚 Entrega: ${_formatarData(entrega.dataEntrega)}'),
                            const SizedBox(height: 8),
                            Text('📝 Info: ${entrega.informacoes}'),
                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Checkbox(
                                  value: entrega.concluido,
                                  onChanged: (value) {
                                    setState(() {
                                      entrega.concluido = value!;
                                    });
                                  },
                                ),
                                const Text("Marcar como concluído"),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () =>
                                      _abrirNoMaps(entrega.endereco),
                                  icon: const Icon(Icons.directions),
                                  label: const Text('VER NO MAPA'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () => setState(
                                      () => _entregas.removeAt(index)),
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