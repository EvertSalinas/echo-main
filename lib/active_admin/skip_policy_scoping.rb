# lib/active_admin/skip_policy_scoping.rb:
module ActiveAdmin
  module SkipPolicyScoping
    extend ActiveSupport::Concern
    included do
      before_filter :skip_policy_scoping
      before_filter :skip_auth, if: 'controller_path == "admin/dashboard"'
    end
    private
    def skip_policy_scoping
      skip_policy_scope
    end

    def skip_auth
      skip_authorization
    end

  end
end
