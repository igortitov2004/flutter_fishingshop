import 'package:fishingshop/model/typeOfReel.dart';
import 'package:fishingshop/model/typeOfRod.dart';
import 'package:fishingshop/service/type_of_reel_repository.dart';
import 'package:fishingshop/service/type_of_rod_repository.dart';
import 'package:flutter/material.dart';

class ReelAndRodTypesScreen extends StatefulWidget {
  const ReelAndRodTypesScreen({Key? key}) : super(key: key);

  @override
  _ReelAndRodTypesScreenState createState() => _ReelAndRodTypesScreenState();
}

class _ReelAndRodTypesScreenState extends State<ReelAndRodTypesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<TypeOfReel>? typesOfReel;
  List<TypeOfRod>? typesOfRod;
  bool isRodSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isRodSelected = _tabController.index == 0; // Устанавливаем значение в зависимости от текущей вкладки
      });
    });
    getTypesOfReel();
    getTypesOfRod();
  }

  Future<void> getTypesOfReel() async {
    typesOfReel = await TypeOfReelRepository.getTypesOfReel();
    setState(() {});
  }

  Future<void> getTypesOfRod() async {
    typesOfRod = await TypeOfRodRepository.getTypesOfRod();
    setState(() {});
  }

  Future<void> _addTypeOfReel(String name) async {
    await TypeOfReelRepository.addTypeOfReel(name, context);
    getTypesOfReel();
  }

  Future<void> _addTypeOfRod(String name) async {
    await TypeOfRodRepository.addTypeOfRod(name, context);
    getTypesOfRod();
  }

  Future<void> _editTypeOfReel(int id, String name) async {
    await TypeOfReelRepository.editTypeOfReel(id, name, context);
    getTypesOfReel();
  }

  Future<void> _editTypeOfRod(int id, String name) async {
    await TypeOfRodRepository.editTypeOfRod(id, name, context);
    getTypesOfRod();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Типы товаров'),
          backgroundColor: Colors.white,
          actions: [
            /*IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  _showAddDialog(isRodSelected);
                }),*/
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Типы удилищ'),
              Tab(text: 'Типы катушек'),
            ],
          ),
        ),
        
        body: Container(
          color: Color(0x1200CCFF),
          child :TabBarView(
          controller: _tabController,
          children: [
            _buildRodTypesList(),
            _buildReelTypesList(),
          ],
        ),
      ),
    ));
  }

  Widget _buildRodTypesList() {
    return typesOfRod == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: typesOfRod!.length,
                  itemBuilder: (context, index) {
                    TypeOfRod typeOfRod = typesOfRod![index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(typeOfRod.type, textAlign: TextAlign.center),
                        //onLongPress: () {
                          //_showEditDialog(typeOfRod.id, typeOfRod.type, true);
                        //},
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }

  Widget _buildReelTypesList() {
    return typesOfReel == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: typesOfReel!.length,
                  itemBuilder: (context, index) {
                    TypeOfReel typeOfReel = typesOfReel![index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(typeOfReel.type, textAlign: TextAlign.center),
                        //onLongPress: () {
                          //_showEditDialog(typeOfReel.id, typeOfReel.type, false);
                        //},
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }

  void _showAddDialog(bool isRod) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              isRod ? 'Добавление типа удилища' : 'Добавление типа катушки'),
          content: TextField(
            controller: controller,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: isRod ? 'Имя типа удилища' : 'Имя типа катушки',
              counterText: 'Макс. 20 символов',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Сохранить'),
              onPressed: () {
                String name = controller.text;
                if (name.isNotEmpty) {
                  if (isRod) {
                    _addTypeOfRod(name);
                  } else {
                    _addTypeOfReel(name);
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(int id, String currentName, bool isRod) {
    TextEditingController controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isRod ? 'Изменение типа удилища' : 'Изменение типа катушки'),
          content: TextField(
            controller: controller,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: isRod ? 'Имя типа удилища' : 'Имя типа катушки',
              counterText: 'Макс. 20 символов',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Сохранить'),
              onPressed: () {
                String name = controller.text;
                if (name.isNotEmpty) {
                  if (isRod) {
                    _editTypeOfRod(id, name);
                  } else {
                    _editTypeOfReel(id, name);
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}