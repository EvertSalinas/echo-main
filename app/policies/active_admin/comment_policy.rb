class ActiveAdmin::CommentPolicy < ApplicationPolicy
  def index?
    false
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
