class EpidemicSheetPolicy < ApplicationPolicy
  def dashboard?
    user.has_any_role?(:admin, :medico, :estadistica)
  end

  def index?
    user.has_any_role?(:admin, :medico, :estadistica)
  end

  def show?
    index?
  end

  def create?
    user.has_any_role?(:admin, :medico, :estadistica)
  end

  def new?
    create?
  end

  def new_contact?
    create?
  end

  def update?
    user.has_any_role?(:admin, :medico, :estadistica)
  end

  def edit?
    update?
  end

  def destroy?
    user.has_any_role?(:admin)
  end

  def delete?
    destroy?
  end
end
