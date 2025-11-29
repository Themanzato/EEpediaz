import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/review.dart';
import '../../providers/review_provider.dart';
import '../../widgets/custom_app_bar.dart';

class ComunidadView extends ConsumerWidget {
  const ComunidadView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewNotifierProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Comunidad',
        actions: [
          Icon(Icons.filter_list),
          SizedBox(width: 16),
        ],
      ),
      body: reviews.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.comments,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay reseñas disponibles',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sé el primero en compartir tu experiencia',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewCard(context, ref, review);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddReviewDialog(context, ref);
        },
        icon: const FaIcon(FontAwesomeIcons.plus),
        label: const Text('Agregar Reseña'),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, WidgetRef ref, Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header de la reseña
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    review.userName.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        review.mapName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildRatingStars(review.rating),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Contenido de la reseña
            Text(
              review.comment,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            
            const SizedBox(height: 12),
            
            // Footer con acciones
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    ref.read(reviewNotifierProvider.notifier).likeReview(
                      review.id,
                      'current_user', // En una app real sería el ID del usuario actual
                    );
                  },
                  icon: FaIcon(
                    review.likes.contains('current_user')
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: review.likes.contains('current_user')
                        ? Colors.red
                        : Colors.grey,
                    size: 16,
                  ),
                ),
                Text(
                  '${review.likes.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    _showCommentsDialog(context, ref, review);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.comment,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
                Text(
                  '${review.comments.length}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  _formatDate(review.date),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return FaIcon(
          FontAwesomeIcons.star,
          size: 16,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inDays < 30) {
      return 'Hace ${(difference.inDays / 7).floor()} semanas';
    } else {
      return 'Hace ${(difference.inDays / 30).floor()} meses';
    }
  }

  void _showAddReviewDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController commentController = TextEditingController();
    String selectedMapId = '';
    double selectedRating = 5.0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Agregar Reseña'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dropdown de mapas
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Seleccionar Mapa',
                    prefixIcon: Icon(Icons.map),
                  ),
                  value: selectedMapId.isEmpty ? null : selectedMapId,
                  items: const [
                    DropdownMenuItem(value: '4', child: Text('The Giant')),
                    DropdownMenuItem(value: '5', child: Text('Der Eisendrache')),
                    DropdownMenuItem(value: '6', child: Text('Zetsubou No Shima')),
                    DropdownMenuItem(value: '7', child: Text('Gorod Krovi')),
                    DropdownMenuItem(value: '8', child: Text('Revelations')),
                    DropdownMenuItem(value: '10', child: Text('Origins')),
                    DropdownMenuItem(value: '11', child: Text('Kino der Toten')),
                    DropdownMenuItem(value: '12', child: Text('Moon')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedMapId = value ?? '';
                    });
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Rating con estrellas
                Text(
                  'Calificación: ${selectedRating.toInt()}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          selectedRating = (index + 1).toDouble();
                        });
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.star,
                        color: index < selectedRating ? Colors.amber : Colors.grey,
                        size: 24,
                      ),
                    );
                  }),
                ),
                
                const SizedBox(height: 16),
                
                // Campo de texto
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Tu reseña',
                    hintText: 'Comparte tu experiencia con este mapa...',
                    prefixIcon: Icon(Icons.comment),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: selectedMapId.isEmpty || commentController.text.trim().isEmpty
                  ? null
                  : () {
                      final review = Review(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userId: 'current_user',
                        userName: 'Usuario Actual',
                        userAvatar: 'https://example.com/avatar.jpg',
                        mapId: selectedMapId,
                        mapName: _getMapName(selectedMapId),
                        rating: selectedRating,
                        comment: commentController.text.trim(),
                        date: DateTime.now(),
                        likes: [],
                        comments: [],
                      );
                      
                      ref.read(reviewNotifierProvider.notifier).addReview(review);
                      Navigator.pop(context);
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reseña agregada exitosamente'),
                        ),
                      );
                    },
              child: const Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }

  String _getMapName(String mapId) {
    switch (mapId) {
      case '4': return 'The Giant';
      case '5': return 'Der Eisendrache';
      case '6': return 'Zetsubou No Shima';
      case '7': return 'Gorod Krovi';
      case '8': return 'Revelations';
      case '10': return 'Origins';
      case '11': return 'Kino der Toten';
      case '12': return 'Moon';
      default: return 'Mapa Desconocido';
    }
  }

  void _showCommentsDialog(BuildContext context, WidgetRef ref, Review review) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Comentarios - ${review.mapName}'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              // Lista de comentarios existentes
              Expanded(
                child: review.comments.isEmpty
                    ? const Center(
                        child: Text('No hay comentarios aún'),
                      )
                    : ListView.builder(
                        itemCount: review.comments.length,
                        itemBuilder: (context, index) {
                          final comment = review.comments[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        child: Text(
                                          comment.userName.substring(0, 1).toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        comment.userName,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatDate(comment.date),
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(comment.text),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              
              const Divider(),
              
              // Campo para nuevo comentario
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Escribe un comentario...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: commentController.text.trim().isEmpty
                        ? null
                        : () {
                            final newComment = ReviewComment(
                              id: DateTime.now().millisecondsSinceEpoch.toString(),
                              userId: 'current_user',
                              userName: 'Usuario Actual',
                              userAvatar: 'https://example.com/avatar.jpg',
                              text: commentController.text.trim(),
                              date: DateTime.now(),
                              likes: [],
                            );
                            
                            ref.read(reviewNotifierProvider.notifier).addComment(
                              review.id,
                              newComment,
                            );
                            
                            commentController.clear();
                            Navigator.pop(context);
                          },
                    icon: const FaIcon(FontAwesomeIcons.paperPlane),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
