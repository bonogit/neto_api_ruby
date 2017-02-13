require "httparty"
require "json"
require "neto_api_ruby/version"

module NetoApiRuby
  class API

  	def initialize url, api_key
  		#required args
  		@neto_url = url
  		#optional args
  		@header_args ={
  		  "Accept"      => "application/json",
  		  "Content-Type"=> "application/json",
  		  "NETOAPI_KEY" => api_key
  		}
  		@body_defaults = {
		    # "Filter"=> {
		        "IsActive"=> ["True"],
		        "OutputSelector"=> [
		            "ID",
                "SKU",
                "ParentSKU",
                "InventoryID",
                "Name",
                "Brand",
                "Description",
                "Active",
                "Visible",
                "Categories",
                "RRP",
                "PromotionPrice",
                "PriceGroups",
                "DateAdded",
                "DateAddedLocal",
                "DateAddedUTC",
                "DateUpdated",
                "DateUpdatedLocal",
                "DateUpdatedUTC",
                "Group",
                "WarehouseQuantity",
                "TaxInclusive"
		        ]
		    # }
		}

  	end
  	#public methods
  	#query    - A Hash with query params, insert into request body
  	#returns the request Array
  	def get_products query={} 
  		do_request :post, 'GetItem', query
  	end


  	protected
  	#Internal methods: Append data as query params to an endpoint

  	def do_request method, action, query={}
  	  url = @neto_url
  	  options = { }
  	  header_action = {
  	  	"NETOAPI_ACTION"=> action
  	  }
  	  #set headers
  	  options[:headers] = @header_args.merge(header_action)
  	  #set body
  	  if query.empty?
	  	options.merge!(body: {"Filter"=> @body_defaults}.to_json)
	  else 
    	body_args = @body_defaults.merge(query) 
    	options.merge!(body: {"Filter"=> body_args}.to_json)
  	  end
  	  HTTParty.send(method, url, options)
  	end

  end
end