# frozen_string_literal: true

# Permissions model for RBAC
class Permission < ApplicationRecord
  validates :role, :req_method, :action, :path, :priority, presence: true
  validate :validate_priority, :on => :create

  before_validation :upcase_action_req_method

  private

  def validate_priority
    return if priority.blank?

    errors.add(:priority, :invalid) unless Permission.where(role: role, req_method: req_method, priority: priority).empty?
  end

  def upcase_action_req_method
    return if action.blank? || req_method.blank?

    self.action.upcase!
    self.req_method.upcase!
  end
end
