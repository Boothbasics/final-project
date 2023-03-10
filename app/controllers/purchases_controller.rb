class PurchasesController < ApplicationController
  def index
    
    @list_of_materials = Material.all.order({ :name => :asc})
    
    @user_id = session[:user_id]
    matching_purchases = Purchase.where({ :user_id => @user_id})
    @list_of_purchases = matching_purchases.order({ :name => :asc })
    render({ :template => "purchases/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_purchases = Purchase.where({ :id => the_id })

    @the_purchase = matching_purchases.at(0)

    render({ :template => "purchases/show.html.erb" })
  end

  def create
    the_purchase = Purchase.new
    the_purchase.user_id = session[:user_id]
    the_purchase.material_id = params.fetch("query_material_id")

    if the_purchase.valid?
      the_purchase.save
      redirect_to("/purchases", { :notice => "Purchase created successfully." })
    else
      redirect_to("/purchases", { :alert => the_purchase.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_purchase = Purchase.where({ :id => the_id }).at(0)

    the_purchase.user_id = params.fetch("query_user_id")
    the_purchase.material_id = params.fetch("query_material_id")

    if the_purchase.valid?
      the_purchase.save
      redirect_to("/purchases/#{the_purchase.id}", { :notice => "Purchase updated successfully."} )
    else
      redirect_to("/purchases/#{the_purchase.id}", { :alert => the_purchase.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_purchase = Purchase.where({ :id => the_id }).at(0)

    the_purchase.destroy

    redirect_to("/purchases", { :notice => "Purchase deleted successfully."} )
  end
end
