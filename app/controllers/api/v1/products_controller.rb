class Api::V1::ProductsController < ApplicationController
    def index 
        products = Product.all
        json_response products, 200
    end

    def create 
        product = current_user.products.build(product_params)
        if product.save
            render json: product, status: 201, location: [:api, product]
        else
            render json: {errors: product.errors}, status: 422
        end
    end

    private 
    def product_params
        params.require(:product).permit(:id, :title, :price, :published)
    end
end
