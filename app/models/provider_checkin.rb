class ProviderCheckin
  include Mongoid::Document

  embedded_in :checkin
end
