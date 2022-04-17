import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firstapp/models/shop_app/categories_model.dart';
import 'package:firstapp/models/shop_app/home_model.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_cubit.dart';
import 'package:firstapp/modules/shop_app/cubit/shop_states.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/end_points.dart';
import 'package:firstapp/shared/network/remote/dio_helper.dart';
import 'package:firstapp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState && state.model!.status == false){
          snkBar(context: context, title: state.model!.message);
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        if (cubit.homeModel == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _ProductsBuilder(
          homeModel: cubit.homeModel,
          categoriesModel: cubit.categoriesModel,
        );
      },
    );
  }
}

class _ProductsBuilder extends StatelessWidget {
  const _ProductsBuilder({
    Key? key,
    required this.homeModel,
    required this.categoriesModel,
  }) : super(key: key);

  final HomeModel? homeModel;
  final CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    if (homeModel != null) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  _CategoriesBuilder(categoriesModel: categoriesModel),
                  const SizedBox(height: 10),
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  GridView.count(
                    crossAxisCount: 2,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1 / 1.7,
                    shrinkWrap: true,
                    children: List.generate(
                      homeModel!.data.products.length,
                      (index) => _BuildGridProduct(
                        productModel: homeModel!.data.products[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}

class _BuildGridProduct extends StatelessWidget {
  const _BuildGridProduct({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final _isFavorite =
        ShopCubit.get(context).favorites[productModel.id] == true;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(productModel.image),
                width: double.maxFinite,
                height: 200,
              ),
              // discount container
              if (productModel.discount > 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6,
                  ),
                  child: Text(
                    '${productModel.discount}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // product name
                Text(
                  productModel.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${productModel.price.floor()} L.E.',
                      style: const TextStyle(
                        fontSize: 14,
                        color: kMainColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (productModel.discount > 0)
                      Text(
                        '${productModel.oldPrice.floor()}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: kGreyColor,
                          decorationStyle: TextDecorationStyle.wavy,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(productModel.id);
                      },
                      icon: Icon(
                        _isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 20,
                        color: _isFavorite
                            ? Colors.pink
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesBuilder extends StatelessWidget {
  const _CategoriesBuilder({
    required this.categoriesModel,
    Key? key,
  }) : super(key: key);

  final CategoriesModel? categoriesModel;

  @override
  Widget build(BuildContext context) {
    if (categoriesModel != null) {
      return SizedBox(
        height: 80,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: NetworkImage(
                      categoriesModel!.data!.data[index].image,
                    ),
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withAlpha(150),
                    width: double.maxFinite,
                    height: double.maxFinite,
                    alignment: Alignment.center,
                    child: Text(
                      categoriesModel!.data!.data[index].name,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          itemCount: categoriesModel!.data!.data.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );
    }

    return const SizedBox();
  }
}
