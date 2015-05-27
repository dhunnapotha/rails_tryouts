Rails.application.routes.draw do

  resources :posts do
    member do
      get :coments 
      post :comments

      resources :author
    end

    collection do
      get :posts_collection
    end

    get :likes, :on => :collection

  end


  namespace :member do
    resources :user
  end

  get 'beer/:name' => 'beer#show', :constraints => {:name => /(budwiser|heineken)/}

  resource :geocoder

end


#                 Prefix Verb   URI Pattern                          Controller#Action
#           coments_post GET    /posts/:id/coments(.:format)         posts#coments
#          comments_post POST   /posts/:id/comments(.:format)        posts#comments
#           author_index GET    /posts/:id/author(.:format)          author#index
#                        POST   /posts/:id/author(.:format)          author#create
#             new_author GET    /posts/:id/author/new(.:format)      author#new
#            edit_author GET    /posts/:id/author/:id/edit(.:format) author#edit
#                 author GET    /posts/:id/author/:id(.:format)      author#show
#                        PATCH  /posts/:id/author/:id(.:format)      author#update
#                        PUT    /posts/:id/author/:id(.:format)      author#update
#                        DELETE /posts/:id/author/:id(.:format)      author#destroy
# posts_collection_posts GET    /posts/posts_collection(.:format)    posts#posts_collection
#            likes_posts GET    /posts/likes(.:format)               posts#likes
#                  posts GET    /posts(.:format)                     posts#index
#                        POST   /posts(.:format)                     posts#create
#               new_post GET    /posts/new(.:format)                 posts#new
#              edit_post GET    /posts/:id/edit(.:format)            posts#edit
#                   post GET    /posts/:id(.:format)                 posts#show
#                        PATCH  /posts/:id(.:format)                 posts#update
#                        PUT    /posts/:id(.:format)                 posts#update
#                        DELETE /posts/:id(.:format)                 posts#destroy
#      member_user_index GET    /member/user(.:format)               member/user#index
#                        POST   /member/user(.:format)               member/user#create
#        new_member_user GET    /member/user/new(.:format)           member/user#new
#       edit_member_user GET    /member/user/:id/edit(.:format)      member/user#edit
#            member_user GET    /member/user/:id(.:format)           member/user#show
#                        PATCH  /member/user/:id(.:format)           member/user#update
#                        PUT    /member/user/:id(.:format)           member/user#update
#                        DELETE /member/user/:id(.:format)           member/user#destroy
#                        GET    /beer/:name(.:format)                beer#show {:name=>/(budwiser|heineken)/}
#               geocoder POST   /geocoder(.:format)                  geocoders#create
#           new_geocoder GET    /geocoder/new(.:format)              geocoders#new
#          edit_geocoder GET    /geocoder/edit(.:format)             geocoders#edit
#                        GET    /geocoder(.:format)                  geocoders#show
#                        PATCH  /geocoder(.:format)                  geocoders#update
#                        PUT    /geocoder(.:format)                  geocoders#update
#                        DELETE /geocoder(.:format)                  geocoders#destroy



