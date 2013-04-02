module Saw
  class Hit < ActiveRecord::Base
    default_scope order('id')
    attr_accessible :url, :http_method, :action, :params, :note, :json_data
    belongs_to :visit
  end
end