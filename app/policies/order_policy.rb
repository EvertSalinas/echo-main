class OrderPolicy < ApplicationPolicy

  def index?
    %w(master almacen ventas accounting).include?(admin_user.role)
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

  def destroy?
    %w(master).include?(admin_user.role)
  end

  def complete?
    %w(master almacen).include?(admin_user.role)
  end

  def pdf?
    %w(master almacen).include?(admin_user.role)
  end

end
