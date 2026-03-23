import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MinhaAgenda(),
    debugShowCheckedModeBanner: false,
  ));
}

class MinhaAgenda extends StatefulWidget {
  // Adicionando o construtor com Key para sumir o aviso azul
  const MinhaAgenda({super.key});

  @override
  State<MinhaAgenda> createState() => _MinhaAgendaState();
}

class _MinhaAgendaState extends State<MinhaAgenda> {
  // Lista para armazenar as tarefas
  final List<String> _tarefas = [];
  // Controlador para o campo de texto
  final TextEditingController _controleTexto = TextEditingController();

  void _adicionarTarefa() {
    setState(() {
      if (_controleTexto.text.isNotEmpty) {
        _tarefas.add(_controleTexto.text);
        _controleTexto.clear();
      }
    });
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda UNIFEOB - Rita'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controleTexto,
                    decoration: const InputDecoration(
                      labelText: 'O que precisa fazer?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _adicionarTarefa,
                  mini: true,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          // Lista de tarefas
          Expanded(
            child: _tarefas.isEmpty
                ? const Center(child: Text('Sua agenda está vazia, diva!'))
                : ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: ListTile(
                          leading: const Icon(Icons.notes, color: Colors.blueAccent),
                          title: Text(_tarefas[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _removerTarefa(index),
                          ),
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