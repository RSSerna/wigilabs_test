import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/di/service_locator.dart';
import 'src/presentation/bloc/countries/countries_bloc.dart';
import 'src/presentation/bloc/country_details/country_details_bloc.dart';
import 'src/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'src/presentation/pages/countries_list_page.dart';
import 'src/presentation/pages/wishlist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountriesBloc>(
          create: (context) => getIt<CountriesBloc>(),
        ),
        BlocProvider<CountryDetailsBloc>(
          create: (context) => getIt<CountryDetailsBloc>(),
        ),
        BlocProvider<WishlistBloc>(
          create: (context) => getIt<WishlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'REST Countries',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CountriesListPage(),
    const WishlistPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Load wishlist on startup
    context.read<WishlistBloc>().add(const LoadWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 1) {
            // Load wishlist when navigating to wishlist page
            context.read<WishlistBloc>().add(const LoadWishlistEvent());
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Countries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}
