class MaterialsController < ApplicationController
  def index
    matching_materials = Material.all

    @list_of_materials = matching_materials.order({ :created_at => :desc })

    render({ :template => "materials/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_materials = Material.where({ :id => the_id })

    @the_material = matching_materials.at(0)

    render({ :template => "materials/show.html.erb" })
  end

  def create
    the_material = Material.new
    the_material.name = params.fetch("query_name")
    the_material.description = params.fetch("query_description")

    if the_material.valid?
      the_material.save
      redirect_to("/materials", { :notice => "Material created successfully." })
    else
      redirect_to("/materials", { :alert => the_material.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    the_material.name = params.fetch("query_name")
    the_material.description = params.fetch("query_description")

    if the_material.valid?
      the_material.save
      redirect_to("/materials/#{the_material.id}", { :notice => "Material updated successfully."} )
    else
      redirect_to("/materials/#{the_material.id}", { :alert => the_material.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_material = Material.where({ :id => the_id }).at(0)

    the_material.destroy

    redirect_to("/materials", { :notice => "Material deleted successfully."} )
  end
end
