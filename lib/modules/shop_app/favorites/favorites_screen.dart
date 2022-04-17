import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is! ShopLoadingGetFavoritesState && cubit.favoritesModel != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: ListView.separated(
              itemBuilder: (context, index) {
                int _productId = cubit.favoritesModel!.data.data[index].product.id;
                return SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      Image(
                        image: NetworkImage(
                          cubit.favoritesModel!.data.data[index].product.image,
                        ),
                        height: 80,
                        width: 80,
                        // fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // product name
                              Expanded(
                                child: Text(
                                  cubit.favoritesModel!.data.data[index].product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${cubit.favoritesModel!.data.data[index].product.price.floor()} L.E.',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: kMainColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  if (cubit.favoritesModel!.data.data[index].product.discount > 0)
                                    Text(
                                      '${cubit.favoritesModel!.data.data[index].product.oldPrice.floor()}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: kGreyColor,
                                        decorationStyle: TextDecorationStyle.wavy,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(
                            cubit.favoritesModel!.data.data[index].product.id,
                          );
                        },
                        icon: Icon(
                          cubit.favorites[_productId]??false
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                          color: cubit.favorites[_productId]??false
                              ? Colors.pink
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cubit.favoritesModel!.data.data.length,
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
