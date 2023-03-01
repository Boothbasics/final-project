desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment }) do

  #Create db entry per new material (model will check for name uniqueness)
  #First testing that it works as implemented here. If it does, may change name of "sample_data" as this is the end dataset.
  1000.times do |count|
    url = "https://www.thecocktaildb.com/api/json/v2/9973533/lookup.php?iid=" + count.to_s
    #Extract data
    materials_data = open(url).read
    parsed_data = JSON.parse(materials_data)
    ingredient_array = parsed_data.fetch("ingredients")

    #break loop if result is nil (e.g. no more ID #'s to process)
    break if ingredient_array == nil
    ingredient_hash = ingredient_array.first

    #Isolate & save material attributes
    m = Material.new
    m.name = ingredient_hash.fetch("strIngredient")
    m.desc = ingredient_hash.fetch("strDescription")
    m.save
  end
end
