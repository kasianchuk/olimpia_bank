class UserPolicy < ApplicationPolicy
  def show?
    user_is_owner_of_record?
  end

  def edit?
    user_is_owner_of_record?
  end

  def update?
    user_is_owner_of_record?
  end

  private

  def user_is_owner_of_record?
    user == record
  end
end
