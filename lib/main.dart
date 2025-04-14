import 'package:cats_tinder/presentation/cubits/cats_state.dart';
import 'package:cats_tinder/presentation/widgets/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'di.dart';
import 'presentation/app/app_router.dart';
import 'presentation/app/app_theme.dart';
import 'presentation/cubits/cats_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const CatTinderApp());
}

class CatTinderApp extends StatelessWidget {
  const CatTinderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CatsCubit>()..loadCats(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Cat Tinder',
        theme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.home,
        builder: (context, child) {
          return BlocListener<CatsCubit, CatsState>(
            listener: (context, state) {
              if (state.status == CatsStatus.error && state.cats.isEmpty) {
                showNetworkErrorDialog(
                  context: context,
                  onRetry: () =>
                      context.read<CatsCubit>().loadCats(isRetry: true),
                );
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
