class AccountPolicy < ApplicationPolicy
  def index?
    user_is_owner?
  end

  def new?
    user_is_owner?
  end

  def show?
    user_is_owner_of_record?
  end

  def edit?
    user_is_owner_of_record?
  end

  def create?
    user_is_owner_of_record?
  end

  def update?
    user_is_owner_of_record?
  end

  def destroy?
    user_is_owner_of_record?
  end

  private

  def user_id
    user.id
  end

  def user_is_owner?
    user_id == params_user_id || record.user_id == user_id
  end

  def user_is_owner_of_record?
    user == record.user
  end
end
