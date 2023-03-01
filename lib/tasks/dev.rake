desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do


  
  #Create db entry per new material (model will check for name uniqueness)
  #Only 100 ingredients so should be quick? May look to set up some sort of periodic checker vs every time.
  1000.times do |count|
    
    url = "https://www.thecocktaildb.com/api/json/v2/9973533/lookup.php?iid="+count
    #extract data
    materials_data = open(url).read
    parsed_data = JSON.parse(materials_data)
    ingredient_array = parsed_data.fetch("ingredients")
    ingredient_hash = ingredient_array.first
    
    #Isolate material names
    
    m = Material.new
    m.name = ingredient_hash.fetch("strIngredient1")
    m.desc = ingredient_hash.fetch("strDescription")
    m.save
  end



end
