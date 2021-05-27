class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def my_bookings?
    true
  end

  def my_events?
    true
  end

  # def new?
  #   true
  # end

  def create?
    true
  end

  def show?
    true
  end

  # def edit?
  #   record.user == user
  # end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
