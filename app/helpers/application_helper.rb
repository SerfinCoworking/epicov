module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  def paginate(collection, params= {})
    will_paginate collection, params.merge(renderer: BootstrapPagination::Rails, previous_label: 'Atras', next_label: 'Siguiente')
  end

  def active_class(link_path)
    if params[:controller] == link_path
      return 'active'
    end
  end

  def active_action(link_path)
    if params[:action] == link_path
      return 'active'
    end
  end

  def active_action_and_controller(action_name, a_controller_name)
    if params[:action] == action_name && controller_name == a_controller_name
      return 'active'
    end
  end

  def order_status_label(an_order)
    if an_order.is_a?(Prescription)
      prescription_status_label(an_order)
    elsif an_order.is_a?(InternalOrder)
      internal_status_label(an_order)
    elsif an_order.is_a?(ExternalOrder)
      ordering_status_label(an_order)
    end
  end

  def user_avatar(user, size=40)
    if user.profile.avatar.attached?
      main_app.url_for(user.profile.avatar.variant(resize: "#{size}x#{size}^", gravity: "center",crop: "#{size}x#{size}+0+0"))
    else
      user.profile.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "profile-placeholder.png")), filename: 'profile-placeholder.png' , content_type: "image/png")
      user.save
      main_app.url_for(user.profile.avatar.variant(resize: "#{size}x#{size}^", gravity: "center",crop: "#{size}x#{size}+0+0"))
    end
  end

  def patient_avatar(patient, first_size=162, second_size=200 )
    if patient.avatar.attached?
      main_app.url_for(patient.avatar.variant(resize: "#{first_size}x#{second_size}^", gravity: "center"))
    else
      patient.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "profile-placeholder.png")), filename: 'profile-placeholder.png' , content_type: "image/png")
      patient.save
      main_app.url_for(patient.avatar.variant(resize: "#{first_size}x#{second_size}^", gravity: "center", crop: "#{first_size}x#{second_size}+0+0"))
    end
  end

  def professional_avatar(professional, size=40)
    if professional.avatar.attached?
      main_app.url_for(professional.avatar.variant(resize: "#{size}x#{size}^", gravity: "center",crop: "#{size}x#{size}+0+0"))
    else
      professional.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "profile-placeholder.png")), filename: 'profile-placeholder.png' , content_type: "image/png")
      professional.save
      main_app.url_for(professional.avatar.variant(resize: "#{size}x#{size}^", gravity: "center",crop: "#{size}x#{size}+0+0"))
    end
  end
end
