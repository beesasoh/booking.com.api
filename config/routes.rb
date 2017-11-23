Rails.application.routes.draw do
  get 'hotels/search'
  get 'hotels/show'

  root 'hotels#index'
end
