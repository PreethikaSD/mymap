require 'json'
require 'byebug'
require 'cgi'

class StoresController < ApplicationController
	# def index
 #  	end

  	def getRequest
	  	if params[:id] and params[:timestamp]
	  		#convert_timestamp = Time.at(params[:timestamp].to_i).utc.strftime('%Y-%m-%d %H:%M:%S')
	  		#convert_timestamp = Time.at(params[:timestamp].to_i).utc
	  		#convert_timestamp = Time.zone.at(params[:timestamp].to_i)
	  		convert_timestamp = Time.at(params[:timestamp].to_i)
	  		byebug
	  		if convert_timestamp
	  			#@store = Store.where("key Like ? AND (updated_at.strftime('%Y-%m-%d %H:%M:%S')) <= ?", params[:id], convert_timestamp).order('updated_at desc').first
	  			@store = Store.where("key Like ? AND updated_at <= ?", params[:id], convert_timestamp).order('updated_at desc').first
	  			
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
	    	Store.create(key: @key, value: @value)
	    	render json: Store.last
	    else
	    	@message = "Please provide the key-value"
	    	redirect_to '/'
	    end	
  	end
end