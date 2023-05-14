// FutureBuilder<List<Veiculo>>(
//         future: dao.getAll(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Text('Erro ao carregar!');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           final data = snapshot.data;
//           if (data != null) {
//             return ListView.builder(
//               itemCount: data.length,
//               padding: const EdgeInsets.all(10),
//               itemBuilder: (context, index) {
//                 final veiculo = data[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Card(
//                     color: Colors.blue,
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ListTile(
//                           title: Text(veiculo.modelo.toUpperCase()),
//                           subtitle: Text(veiculo.placa.toUpperCase()),
//                         ),
//                         ListTile(
//                           title: const Text('MOTORISTA'),
//                           subtitle:
//                               Text(veiculo.motorista.toString().toUpperCase()),
//                           trailing: IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const AgendamentoScreen(),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.add),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//           return const Text('Sem dados');
//         },
//       ),