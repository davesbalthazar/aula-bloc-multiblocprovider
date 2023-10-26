import 'dart:math';

import 'package:aula_bloc_multiblocprovider/product/bloc/product_bloc.dart';
import 'package:aula_bloc_multiblocprovider/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aula Bloc - MultiBlocProvider'),
        ),
        body: SizedBox.expand(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UserBloc(),
              ),
              BlocProvider(
                create: (context) => ProductBloc(),
              ),
            ],
            child: BlocBuilder<UserBloc, UserState>(
              builder: (userContext, userState) {
                if (userState is UserInitial) {
                  return BlocBuilder<ProductBloc, ProductState>(
                    builder: (productContext, productState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Usuário não logado'),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            onPressed: () => userContext.read<UserBloc>().add(
                                  const UserLogin('1', 'Daves'),
                                ),
                            child: const Text('Login'),
                          ),
                        ],
                      );
                    },
                  );
                }
                if (userState is UserLoogedIn) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Id Usuario: ${userState.userId}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nome: ${userState.userName}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          var rng = Random();

                          // Opção A
                          // BlocProvider.of<UserBloc>(userContext).add(UserLogin(
                          //     Random().nextInt(100).toString(), 'Pedro'));

                          // Opção B
                          userContext.read<UserBloc>().add(
                                UserLogin(
                                  rng.nextInt(100).toString(),
                                  'Pedro',
                                ),
                              );
                        },
                        child: const Text('Mudar Valor'),
                      ),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ));
  }
}
