module ApplicationHelper
  def active?(status)
    status ? 'success' : 'danger'
  end

  def swal_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert' then 'warning'
    when 'danger', 'error', 'denied' then 'error'
    when 'question' then 'question'
    else 'info'
    end
  end

  def enterprises
    @enterprises ||= current_user.roles.includes(:enterprise).map(&:enterprise)
  end

  def abbreviation(word)
    word.split.map(&:first).join.upcase
  end

  def formatted(document_number)
    case document_number.size
    when 11
      CPF.new(document_number).formatted
    when 14
      CNPJ.new(document_number).formatted
    end
  end

  def not_persisted_action?
    ['new', 'create'].include?(action_name)
  end

  def current_role_kind
    current_user.roles.find_by(enterprise: current_user.current_enterprise).kind
  end

  def can_access_admin?
    return unless current_user.present? && current_user.current_enterprise.present?

    User::Role::ADMIN_KINDS.include?(current_role_kind)
  end
end
