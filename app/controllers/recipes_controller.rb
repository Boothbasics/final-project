class RecipesController < ApplicationController
  
  def homepage
    
    #Identify purchases tied to user account
    @user_id = session[:user_id]
    @matching_purchases = Purchase.where({ :user_id => @user_id})
    
    #Identify materials tied to user account
    matching_material_ids = @matching_purchases.map_relation_to_array(:material_id)

    #Identify ingredients not tied to materials tied to user account, to identify a list of recipes that contain absent ingredients
    impossible_recipe_ids = Ingredient.where.not({ :material_id => matching_material_ids}).map_relation_to_array(:recipe_id)

    #Build a list of recipes excluding the id's of "impossible recipes" that use absent ingredients
    matching_recipes = Recipe.where.not({:id => impossible_recipe_ids})

    @list_of_recipes = matching_recipes.order({ :name => :asc })

    render({ :template => "recipes/personalized.html.erb" })
  end

  def index
    matching_recipes = Recipe.all

    @list_of_recipes = matching_recipes.order({ :name => :asc })

    render({ :template => "recipes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_recipes = Recipe.where({ :id => the_id })

    @the_recipe = matching_recipes.at(0)

    render({ :template => "recipes/show.html.erb" })
  end

  def create
    the_recipe = Recipe.new
    the_recipe.name = params.fetch("query_name")
    the_recipe.instructions = params.fetch("query_instructions")
    the_recipe.image = params.fetch("query_image")
    the_recipe.user_id = params.fetch("query_user_id")
    the_recipe.ingredients_count = params.fetch("query_ingredients_count")

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes", { :notice => "Recipe created successfully." })
    else
      redirect_to("/recipes", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.name = params.fetch("query_name")
    the_recipe.instructions = params.fetch("query_instructions")
    the_recipe.image = params.fetch("query_image")
    the_recipe.user_id = params.fetch("query_user_id")
    the_recipe.ingredients_count = params.fetch("query_ingredients_count")

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully."} )
    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.destroy

    redirect_to("/recipes", { :notice => "Recipe deleted successfully."} )
  end
end
