#  github_challenge

### VSCode

Running a Flutter project in VSCode
To run a Flutter project in VSCode, follow these steps:

Open VSCode and open the folder containing your Flutter project.
Open the terminal in VSCode by going to Terminal > New Terminal.
Make sure your device is connected and recognized by running flutter devices in the terminal. If your device is not recognized, try reconnecting it or restarting VSCode.
Run the command flutter run in the terminal. This will build and run your Flutter app on your connected device.
For more information on running Flutter projects in VSCode, see the official Flutter documentation here, and follow all steps.

[Flutter Oficial Documentation](https://docs.flutter.dev/get-started/install)

### Demo

https://user-images.githubusercontent.com/58753717/229949951-ab5d0d26-ccff-4851-8399-b00b1279780b.mp4

### Using the BLoC pattern with Cubit, Get_it, Go_router, and Sqflite
The BLoC pattern is a popular state management pattern in Flutter, and there are several libraries that can help you implement it, including Cubit, Get_it, Go_router, and Sqflite. Here is a brief overview of each library and how to use them:

### Useful links:

[get_it](https://pub.dev/packages/get_it)

[flutter_bloc](https://pub.dev/packages/flutter_bloc)

[go_router](https://pub.dev/packages/go_router)

[sqflite](https://pub.dev/packages/sqflite)

### Cubit
Cubit is a library that provides a simple way to implement BLoCs in Flutter. To use Cubit, you'll need to define a class that extends Cubit and implement its mapEventToState method. Here's an example:

```
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}
```

In this example, we're defining a CounterCubit class that extends Cubit<int>. We're also defining two methods, increment() and decrement(), that increment and decrement the current state by 1, respectively. To use this cubit in our UI, we can use the BlocBuilder widget:

```
BlocBuilder<CounterCubit, int>(
  builder: (context, state) {
    return Text('Count: $state');
  },
),
```

Here, we're using the BlocBuilder widget to build a Text widget that displays the current count. The BlocBuilder widget takes two type parameters: the first is the type of the cubit (CounterCubit), and the second is the type of the state (int).

For more information on using Cubit, see the official documentation here.

### Get_it
Get_it is a simple service locator library that allows you to register and retrieve dependencies in your Flutter app. To use Get_it, you'll need to register your dependencies and then retrieve them where needed. Here's an example:

```
final counter = GetIt.I.get<CounterCubit>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider.value(
          value: counter,
          child: CounterPage(),
        ),
      ),
    );
  }
}
```

In this example, we're registering a CounterCubit dependency using GetIt.I.registerSingleton(). We're then using BlocProvider.value() to provide this dependency to our CounterPage.

For more information on using Get_it, see the official documentation here.

### Go_router
Go_router is a simple and lightweight routing library for Flutter that makes it easy to navigate between screens in your app. To use Go_router, you'll need to define your routes and then navigate to them where needed. Here's an example:

```
final router = GoRouter(
  routes: [
    GoRoute(
      name: '/',
      pageBuilder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: '/profile/:id',
      pageBuilder: (context, state) => ProfilePage(id: state.params['id']),
    ),
    GoRoute(
      name: '/settings',
      pageBuilder: (context, state) => SettingsPage(),
      transitionDuration: Duration(milliseconds: 500),
      transitionCurve: Curves.easeOut,
      transitionType: TransitionType.fadeIn,
    ),
  ],
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
```

In this example, we're defining three routes using GoRoute. The first route is the home page, which is mapped to the root route ('/'). The second route is the profile page, which takes an id parameter and is mapped to '/profile/:id'. The third route is the settings page, which has a custom transition duration, curve, and type.

To navigate between routes, you can use the GoRouter.of(context).go() method, like this:

```
GoRouter.of(context).go('/profile/123');
```

For more information on using Go_router, see the official documentation here.

### Sqflite
Sqflite is a lightweight library that provides a simple way to use SQLite databases in Flutter. To use Sqflite, you'll need to create a database and define your tables. Here's an example:

```
final database = await openDatabase(
  path.join(await getDatabasesPath(), 'my_database.db'),
  onCreate: (db, version) async {
    await db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)');
  },
  version: 1,
);

class UserRepository {
  final Database _database = database;

  Future<List<User>> getUsers() async {
    final List<Map<String, dynamic>> maps = await _database.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<void> insertUser(User user) async {
    await _database.insert('users', user.toMap());
  }

  Future<void> updateUser(User user) async {
    await _database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    await _database.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
```
In this example, we're creating a users table in our database with an id and name column. We're also defining a UserRepository class that provides methods to interact with our database, including getUsers(), insertUser(), updateUser(), and deleteUser().

For more information on using Sqflite, see the official documentation here.

I hope this documentation helps you get started with using Cubit, Get_it, Go_router, and Sqflite in your Flutter app! If you have any questions or need further assistance, feel free to consult the official documentation for each library or reach out to the
community for help. Happy coding!



Carlos Henrique
