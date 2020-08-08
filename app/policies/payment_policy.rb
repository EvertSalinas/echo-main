class PaymentPolicy < ApplicationPolicy

  def index?
    %w(master accounting).include?(admin_user.role)
  end

  def show?
    index?
  end

  def new?
    false
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    edit?
  end

end
