class Provider
  include HTTParty
  
  include Mongoid::Document
  
  belongs_to :user
  
  field :token
  field :uid
  
  def self.merge_options_for_url(options)
    options.inject('') do |urlized, (key, value)|
      urlized += urlized.empty? ? "?#{key}=#{value}" : "&#{key}=#{value}"
    end
  end
  
end
