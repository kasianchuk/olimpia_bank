module Services
  module Authorization
    class AccountContext
      attr_reader :user, :params_user_id

      def initialize(current_user, params_user_id)
        @user = current_user
        @params_user_id = params_user_id
      end
    end
  end
end
