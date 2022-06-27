class OrderDetailPolicy < ApplicationPolicy

  def index?
    %w(master almacen ventas accounting).include?(admin_user.role)
  end

  def show?
    false
  end

  def new?
    false
  end

  def create?
    false
  end

  def edit?
    false
  end

  def update?
    false
  end

end
