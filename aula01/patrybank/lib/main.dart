import 'package:flutter/material.dart';

void main() {
  runApp(const PatryBankApp());
}

class PatryBankApp extends StatelessWidget {
  const PatryBankApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  FormularioTransferencia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF185A2D),
          title: const Text(
            'Criando Transferência',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controladorCampoNumeroConta,
                style: const TextStyle(fontSize: 24.0),
                decoration: const InputDecoration(
                    labelText: 'Número da conta',
                    hintText: '0000' // <- placeholder
                    ),
                keyboardType:
                    TextInputType.number, // transforma em teclado numérico
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: TextField(
                controller: _controladorCampoValor,
                style: const TextStyle(fontSize: 24.0),
                decoration: const InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: 'Valor',
                    hintText: '0.00' // placeholder
                    ),
                keyboardType:
                    TextInputType.number, // transforma em teclado numérico
              ),
            ),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () {
                debugPrint('clicou no confirmar');
                final int? numeroConta =
                    int.tryParse(_controladorCampoNumeroConta.text);
                final double? valor =
                    double.tryParse(_controladorCampoValor.text);

                if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  debugPrint('$transferenciaCriada');
                }
              },
            )
          ],
        ));
  }
}

class ListaTransferencias extends StatelessWidget {
  const ListaTransferencias({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Transferências', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100, 12345)),
          ItemTransferencia(Transferencia(200, 85554)),
          ItemTransferencia(Transferencia(300, 9815)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia; // _atributo privado

  const ItemTransferencia(this._transferencia, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
  @override
  String toString() {
    // TODO: implement toString
    return 'Transerencia:{valor: $valor, numero da conta: $numeroConta}';
  }
}
