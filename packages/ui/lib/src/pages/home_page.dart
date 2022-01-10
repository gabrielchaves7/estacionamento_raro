import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/src/bloc/registro/registro_cubit.dart';
import 'package:ui/src/bloc/vaga/vagas_cubit.dart';
import 'package:ui/src/injection.dart';
import 'package:ui/src/widgets/registros/registros_widget.dart';
import 'package:ui/src/widgets/vagas/vagas_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final VagasCubit _vagasCubit = getIt<VagasCubit>();
  final RegistroCubit _registroCubit = getIt<RegistroCubit>();

  static final List<Widget> _widgetOptions = <Widget>[
    VagasWidget(),
    RegistrosWidget()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _vagasCubit.getVagas();
    _registroCubit.getRegistros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<VagasCubit>(
              create: (BuildContext context) => _vagasCubit,
            ),
            BlocProvider<RegistroCubit>(
              create: (BuildContext context) => _registroCubit,
            ),
          ],
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            label: 'Vagas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drive_file_rename_outline),
            label: 'Registros',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
