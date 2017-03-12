Rails.application.routes.draw do
  root 'transcripts#index'
  resources :transcripts do
    put :update_transcript_ajax
    put :undo_transcript
    put :redo_transcript
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/show' => 'streams#show', via: :get, defaults: { format: :csv }
  resources :streams, only: [:index] do
    collection do
      get :video_download
      post :message
    end
  end 
end
