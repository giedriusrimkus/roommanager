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

		@product = current_user.products.build(product_params)

		if @product.save
			flash[:success] = "Product submitted!"
			redirect_to root_path # user_path(current_user.id)
		else
			render 'pages/home'
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			flash[:success] = "Product updated"
			redirect_to root_path
		else
			flash[:danger] = "Error updating product!"
			render :edit
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		flash[:success] = "Product deleted"
		redirect_to root_path
	end

	private

	def product_params
		params.require(:product).permit(:name, :description, :price)
	end

end
