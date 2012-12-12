# Patches Redmine's Users dynamically.
module OauthProviderUserPatch
  def self.included(base) # :nodoc:
    base.class_eval do
      unloadable

      has_many :client_applications
      has_many :tokens, :class_name => "OauthToken", :order => "authorized_at desc", :include => [:client_application]
    end
  end
end
