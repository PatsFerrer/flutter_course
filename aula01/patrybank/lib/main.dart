import 'package:flutter/material.dart';

void main() => runApp(const PatryBankApp());

class PatryBankApp extends StatelessWidget {
  const PatryBankApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
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
            NossoInputPersonalizado(
                controlador: _controladorCampoNumeroConta,
                labelTexto: 'Número da Conta',
                dica: '0000'),
            NossoInputPersonalizado(
              controlador: _controladorCampoValor,
              labelTexto: 'Valor',
              dica: '000.0',
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              child: const Text('Confirmar'),
              onPressed: () => _criaTransferencia(context), // método extraído
            )
          ],
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('criando transferencia');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class NossoInputPersonalizado extends StatelessWidget {
  final TextEditingController? controlador;
  final String? labelTexto;
  final String? dica;
  final IconData? icone;

  const NossoInputPersonalizado(
      {super.key, this.controlador, this.labelTexto, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: labelTexto,
          hintText: dica, // <- placeholder
        ),
        keyboardType: TextInputType.number, // transforma em teclado numérico
      ),
    );
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
        child: const Icon(Icons.add),
        onPressed: () {
          // MaterialPageRoute <- rota do material design
          final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
          });
        },
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
