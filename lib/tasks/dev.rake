desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment }) do

  #Create db entry per new material (model will check for name uniqueness)
  #First testing that it works as implemented here. If it does, may change name of "sample_data" as this is the end dataset.
  1000.times do |count|
    #Start count at 1
    id_num = count + 1
    url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=" + id_num.to_s
    #Extract data
    materials_data = URI.open(url).read
    parsed_data = JSON.parse(materials_data)
    ingredient_array = parsed_data.fetch("ingredients")

    # Uncomment to break loop if result is nil (e.g. no more ID #'s to process). However, API currently has blank gaps
    # break if ingredient_array == nil
    if ingredient_array == nil
      next
    else
      ingredient_hash = ingredient_array.first
    end

    #Isolate & save material attributes
    m = Material.new
    m.name = ingredient_hash.fetch("strIngredient").capitalize
    m.description = ingredient_hash.fetch("strDescription")
    m.save

    # Check for error messages
    # Print(m.errors.full_messages)
    
  end
end
