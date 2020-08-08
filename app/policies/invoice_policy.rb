class InvoicePolicy < ApplicationPolicy

  def index?
    %w(master accounting).include?(admin_user.role)
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

end
