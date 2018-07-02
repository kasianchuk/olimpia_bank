module Services
  module Authorization
    class AccountContext
      attr_reader :user, :params_user_id

      def initialize(options = {})
        @user = options.fetch(:current_user)
        @params_user_id = options.fetch(:params_user_id)
      end
    end
  end
end
