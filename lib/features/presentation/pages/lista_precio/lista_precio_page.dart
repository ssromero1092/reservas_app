import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reservas_app/core/constants/k_padding.dart';
import 'package:reservas_app/features/presentation/blocs/lista_precio/lista_precio_bloc.dart';
import 'package:reservas_app/features/presentation/pages/lista_precio/widgets/lista_precio_create_form.dart';
import 'package:reservas_app/features/presentation/pages/lista_precio/widgets/lista_precio_delete_form.dart';
import 'package:reservas_app/features/presentation/pages/lista_precio/widgets/lista_precio_edit_form.dart';
import 'package:reservas_app/features/presentation/pages/widgets/base_scaffold.dart';
import 'package:reservas_app/features/presentation/pages/widgets/error_state_widget.dart';
import 'package:toastification/toastification.dart';

class ListaPrecioPage extends StatefulWidget {
  const ListaPrecioPage({super.key});

  @override
  State<ListaPrecioPage> createState() => _ListaPrecioPageState();
}

class _ListaPrecioPageState extends State<ListaPrecioPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState(){
    super.initState();
    context.read<ListaPrecioBloc>().add(const LoadListaPrecios());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final toastification = Toastification();
    
    return BaseScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.price_change, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Lista de Precios'),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 8,
        actions: [
          IconButton(
            onPressed: () => context.go('/home'),
            icon: const Icon(Icons.home),
            tooltip: 'Ir al inicio',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.colorScheme.primary.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: KPadding.horizontalSM,
            child: BlocConsumer<ListaPrecioBloc, ListaPrecioState>(
              listener: (context, state) {
                if (state is ListaPrecioSuccess) {
                  toastification.show(
                    context: context,
                    title: Text(state.message),
                    type: ToastificationType.success,
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                } else if (state is ListaPrecioError) {
                  toastification.show(
                    context: context,
                    title: Text(state.message),
                    type: ToastificationType.error,
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                }
              },
              builder: (context, state) {
                return _buildContent(context, state, theme);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ListaPrecioState state,
    ThemeData theme,
  ) {
    if (state is ListaPrecioLoading) {
      return _buildLoadingState(theme);
    } else if (state is ListaPrecioLoaded) {
      return _buildLoadedState(state, theme, context);
    } else if (state is ListaPrecioError) {
      return _buildErrorState(state, theme, context);
    } else {
      return _buildInitialState(theme, context);
    }
  }

  Widget _buildSearchField(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: 'Buscar por precio, tipo hospedaje, tipo precio...',
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    size: 18,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ListaPrecioBloc>().add(const SearchListaPrecios(''));
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: theme.colorScheme.surface.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: theme.colorScheme.primary.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
        style: const TextStyle(fontSize: 14),
        onChanged: (value) {
          context.read<ListaPrecioBloc>().add(SearchListaPrecios(value));
          setState(() {});
        },
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.waveDots(
              color: theme.colorScheme.primary,
              size: 50,
            ),
            const SizedBox(height: 16),
            Text(
              'Cargando lista de precios...',
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedState(
    ListaPrecioLoaded state,
    ThemeData theme,
    BuildContext context,
  ) {
    if (state.listaPrecios.isEmpty) {
      return Card(
        elevation: 4,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.price_change_outlined,
                size: 80,
                color: theme.colorScheme.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'No hay listas de precio registradas',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => CreateListaPrecioDialog.show(context, theme),
                icon: const Icon(Icons.add),
                label: const Text('Crear Primera Lista de Precio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final displayList = state.displayList;
    final showingFiltered = state.searchQuery.isNotEmpty;

    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            showingFiltered 
                                ? 'Resultados (${displayList.length} de ${state.listaPrecios.length})'
                                : 'Lista de Precios (${state.listaPrecios.length})',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          if (showingFiltered)
                            Text(
                              'Buscando: "${state.searchQuery}"',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary.withOpacity(0.7),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => CreateListaPrecioDialog.show(context, theme),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Nuevo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSearchField(theme),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<ListaPrecioBloc>().add(const LoadListaPrecios());
                // Esperar un poco para que se complete la carga
                await Future.delayed(const Duration(milliseconds: 500));
              },
              color: theme.colorScheme.primary,
              backgroundColor: Colors.white,
              child: displayList.isEmpty && showingFiltered
                  ? _buildNoResultsFound(theme)
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: displayList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final listaPrecio = displayList[index];
                        return _buildListaPrecioCard(listaPrecio, theme, context);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsFound(ThemeData theme) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: 400, // Altura mínima para permitir el scroll
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 60,
              color: theme.colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No se encontraron resultados',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otros términos de búsqueda',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListaPrecioCard(
    dynamic listaPrecio,
    ThemeData theme,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${listaPrecio.valor.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                      style: theme.textTheme.headlineSmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (listaPrecio.tipoHospedaje != null) ...[
                      Text(
                        'Tipo Hospedaje: ${listaPrecio.tipoHospedaje!.descripcion}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        listaPrecio.tipoHospedaje!.equipamiento,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    if (listaPrecio.tipoPrecio != null) ...[
                      Text(
                        'Tipo Precio: ${listaPrecio.tipoPrecio!.descripcion}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        listaPrecio.tipoPrecio!.observacion,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                    Text('id: ${listaPrecio.idListaPrecio}'),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () => EditListaPrecioDialog.show(
                      context,
                      theme,
                      listaPrecio,
                    ),
                    icon: Icon(Icons.edit, color: Colors.blue[600]),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => DeleteListaPrecioDialog.show(
                      context,
                      theme,
                      listaPrecio,
                    ),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[600],
                    ),
                    tooltip: 'Eliminar',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    ListaPrecioError state,
    ThemeData theme,
    BuildContext context,
  ) {
    return ErrorStateWidget.listaPrecios(
      message: state.message,
      onRetry: () {
        context.read<ListaPrecioBloc>().add(const LoadListaPrecios());
      },
    );
  }

  Widget _buildInitialState(ThemeData theme, BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.price_change_outlined,
              size: 80,
              color: theme.colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Lista de Precios',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Gestiona los precios de los diferentes tipos de hospedaje.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<ListaPrecioBloc>().add(const LoadListaPrecios());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Cargar Lista de Precios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
