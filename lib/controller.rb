require 'sinatra'
require './lib/gossip'
require 'csv'

class ApplicationController < Sinatra::Base

	get '/'do
        erb:index , locals:{gossips: Gossip.all}
	end

	get '/gossips/:id' do
		erb:gossip_show , 
		locals:{
			gossip: Gossip.find(params[:id].to_i), 
			index: params[:id].to_i
		}
	end

	#modifie base donnée et renvoy à l'accueil 
	post '/gossips/:id/edit/'do
		data=Gossip.all
		data[(params[:id].to_i)].content=params[:Content]
		Gossip.update(data)
		redirect '/'
	end

	#affiche page avec formulaire de modif de potin
	get '/gossips/:id/edit/'do
		erb:gossip_edit,
		locals:{index: params[:id]}
	end


	get '/gossips/new/'do
		erb:new_gossip 
	end

	post '/gossips/new/' do
		Gossip.new(params["Author"],params["Content"]).save
		puts "Gossip created : #{params}"

		#redirige vers la page d'accueil
		redirect '/'
	end

end