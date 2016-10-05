require 'json'
require 'cgi'

class StoresController < ApplicationController

  	def getRequest
	  	if params[:id] and params[:timestamp]
	  		if params[:timestamp].to_i != 0
	  			@store = Store.where("key Like ? AND convert_date <= ?", params[:id], params[:timestamp].to_i).order('updated_at desc').first
	  			
	  			if @store
	  				render json: @store.value
	  			else
	  				@message = "The record was not found"
	  				render json: @message
	  			end
	  		else
	  			@message = "Please enter a valid timestamp"	
	  			render json: @message
	  		end	
	  	elsif params[:id]	
	  		@store = Store.where(key: params[:id]).order('updated_at desc').first
	  		if @store
	  			@key = @store.key
	  			@value = @store.value
	  			render json: @store.value
	  		else
	  			@message = "Value for key #{params[:id]} is not present in the database"
	  			render json: @message
	  		end  		
	  	else
	  		@message = "Please enter a key"
	  		render json: @message
	  	end	
  	end

  	def create
	    @key = params.keys[0]
	    @value = params.values[0]
	    if @key and @value
	    	@store = Store.create(key: @key, value: @value)
	    	convert_updated_at = @store.updated_at.to_i
	    	@store.update(convert_date: convert_updated_at)
	    	render json: @store
	    else
	    	@message = "Please provide the key-value"
	    	redirect_to '/'
	    end	
  	end
end