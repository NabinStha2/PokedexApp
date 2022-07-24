import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedexapp/pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedexapp/pokedex/bloc/pokemon_details_bloc.dart';
import 'package:pokedexapp/pokedex/screen/pokedex_details.dart';
import 'package:pokedexapp/pokedex/screen/pokedex_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(
          create: (context) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
        ),
        BlocProvider<PokemonDetailsBloc>(
          create: (context) => PokemonDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        // darkTheme: ThemeData.dark().copyWith(
        //   brightness: Brightness.dark,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        //   iconTheme: IconThemeData(
        //     color: Colors.black,
        //   ),
        //   primaryColorDark: Colors.black,
        //   appBarTheme: AppBarTheme(
        //     backgroundColor: Colors.black45,
        //   ),
        //   scaffoldBackgroundColor: Colors.white,
        //   textTheme: Theme.of(context).textTheme,
        // ),
        // themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          // textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: Theme.of(context).textTheme,
        ),
        // home: BottomNavScreen(),
        // routes: {
        //   "/": (context) => BlocProvider.value(
        //         value: BlocProvider.of<PokemonBloc>(context),
        //         child: PokedexScreen(),
        //       ),
        //   "/pokedexDetails": (context) => BlocProvider.value(
        //         value: BlocProvider.of<PokemonDetailsBloc>(context),
        //         child: PokedexDetails(),
        //       ),
        // },
        onGenerateRoute: (settings) {
          if (settings.name == "/") {
            return MaterialPageRoute(builder: (_) => PokedexScreen());
          }
          if (settings.name == "/pokedexDetails") {
            final args = settings.arguments as int;
            return MaterialPageRoute(
                builder: (_) => PokedexDetails(pokemonId: args));
          }
          return null;
        },
        // home: MultiBlocProvider(
        //   providers: [
        //     BlocProvider<PokemonBloc>(
        //       create: (context) =>
        //           PokemonBloc()..add(PokemonPageRequest(page: 0)),
        //     ),
        //     BlocProvider<PokemonDetailsBloc>(
        //       create: (context) => PokemonDetailsBloc(),
        //     ),
        //   ],
        //   child: PokedexScreen(),
        // ),
      ),
    );
  }
}
