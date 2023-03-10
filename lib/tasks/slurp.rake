namespace :slurp do
  desc "TODO"
  task recipes: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "cocktail_list.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      #Extract cocktail name for recipe search
      cocktail_name = row[0].gsub(" ","%20")

      if cocktail_name.include?"xA"
        next
      end
      
      begin
        url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=" + cocktail_name
      rescue InvalidURIError
        next
      end
      #Extract data
      recipe_data = URI.open(url).read
      parsed_data = JSON.parse(recipe_data)
      recipe_array = parsed_data.fetch("drinks")
      
      #skip attempt if result is nil
      if recipe_array == nil
        next
      else
        recipe_hash = recipe_array.first
      end
      print(recipe_hash.fetch("strDrink"))
  
      #Isolate & save material attributes
      r = Recipe.new
      r.name = recipe_hash.fetch("strDrink")
      r.instructions = recipe_hash.fetch("strInstructions")
      r.image = recipe_hash.fetch("strDrinkThumb")
      r.save
      puts "#{r.name} saved"
      
      15.times do |count|
        id_num = count + 1
        ing_name = recipe_hash.fetch("strIngredient"+id_num.to_s)
        if ing_name == nil
          break
        end
        
        i = Ingredient.new
        i.measure = recipe_hash.fetch("strMeasure"+id_num.to_s)
        i.recipe_id = r.id
        
        #Check whether material exists in database. If not, create material record
        ref_material = Material.all.where({ :name => ing_name}).first
        if ref_material == nil
          m = Material.new
          m.name = ing_name
          m.save
          i.material_id = m.id
        else
          i.material_id = Material.all.where({ :name => ing_name}).first.fetch(:id)
        end
        
        i.save
        
      end
    end
    
    puts "There are now #{Recipe.count} rows in the recipes table"
  end

end
