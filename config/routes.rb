Rails.application.routes.draw do



  # Routes for the Purchase resource:

  # CREATE
  post("/insert_purchase", { :controller => "purchases", :action => "create" })
          
  # READ
  get("/purchases", { :controller => "purchases", :action => "index" })
  
  get("/purchases/:path_id", { :controller => "purchases", :action => "show" })
  
  # UPDATE
  
  post("/modify_purchase/:path_id", { :controller => "purchases", :action => "update" })
  
  # DELETE
  get("/delete_purchase/:path_id", { :controller => "purchases", :action => "destroy" })

  #------------------------------

  # Routes for the Material resource:

  # CREATE
  post("/insert_material", { :controller => "materials", :action => "create" })
          
  # READ
  get("/materials", { :controller => "materials", :action => "index" })
  
  get("/materials/:path_id", { :controller => "materials", :action => "show" })
  
  # UPDATE
  
  post("/modify_material/:path_id", { :controller => "materials", :action => "update" })
  
  # DELETE
  get("/delete_material/:path_id", { :controller => "materials", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
