import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      // Scaffold é o esqueleto
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transferências',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ), // AppBar é a parte de cima
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: ListaTransferencias(),
      ),
    ),
  );
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(Transferencia(100, 12345)),
        ItemTransferencia(Transferencia(200, 85554)),
        ItemTransferencia(Transferencia(300, 9815)),
      ],
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
}
