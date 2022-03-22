class OrderPolicy < ApplicationPolicy

  def index?
    %w(master almacen ventas).include?(admin_user.role)
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
