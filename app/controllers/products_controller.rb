class ProductsController < ApplicationController
	
	def index
		@products = Product.all.order('created_at DESC')
	end

	def show
		@product = Product.find(params[:id])
	end


	def new
		@product = Product.new
	end

	def create

		@product = Product.new(product_params)

		if @product.save
			flash[:success] = "Product submitted"
			redirect_to @product
		else
			flash[:danger] = "Error coccured"
			render :new
		end
	end


	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			flash[:success] = "Product updated"
			redirect_to @product
		else
			flash[:danger] = "Error updating product!"
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		flash[:success] = "Product deleted"
		redirect_to products_path
	end

	private

	def product_params
		params.require(:product).permit(:name, :description, :price)
	end

end
