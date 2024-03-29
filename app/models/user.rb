class User < ApplicationRecord
  rolify
  include PgSearch::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable, :database_authenticatable
  devise :ldap_authenticatable, :authentication_keys => [:username]

  # Relaciones
  has_many :user_sectors
  has_many :sectors, :through => :user_sectors
  belongs_to :sector, optional: true
  has_many :establishments, :through => :sectors
  has_one :profile, :dependent => :destroy
  has_one :professional, :dependent => :destroy
  has_many :permission_requests, :dependent => :destroy
  has_many :epidemic_sheets, foreign_key: :created_by

  accepts_nested_attributes_for :profile, :professional

  validates :username, presence: true, uniqueness: true

  after_create :create_profile # Comment in development

  # Delegaciones
  delegate :full_name, :dni, :email, to: :profile
  delegate :name, :establishment_short_name, to: :sector, prefix: :sector
  delegate :establishment_name, to: :sector
  delegate :establishment, :establishment_city, to: :sector

  def create_profile
    first_name = Devise::LDAP::Adapter.get_ldap_param(self.username, "givenname").first.encode("Windows-1252", invalid: :replace, undef: :replace) # Comment in production
    last_name = Devise::LDAP::Adapter.get_ldap_param(self.username, "sn").first.encode("Windows-1252", invalid: :replace, undef: :replace)
    email = Devise::LDAP::Adapter.get_ldap_param(self.username, "mail").present? ? Devise::LDAP::Adapter.get_ldap_param(self.username, "mail").first : "Sin email"
    dni = Devise::LDAP::Adapter.get_ldap_param(self.username, "uid").present? ? Devise::LDAP::Adapter.get_ldap_param(self.username, "uid").first : "Sin DNI"
    Profile.create(user: self, first_name: first_name, last_name: last_name, email: email, dni: dni)
  end

  after_save :verify_profile

  def verify_profile
    unless self.profile.present?
      self.create_profile # Comment in development
    end
    unless self.sector.present?
      if self.sectors.present?
        self.sector = self.sectors.first
        self.save
      end
    end
  end

  def valid_password?(password)
    Devise::Encryptor.compare(self.class, encrypted_password, password)
  end

  # hack for remember_token
  def authenticatable_salt
    Digest::SHA1.hexdigest(username)[0,29]
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :search_username,
      :search_by_fullname,
      :sorted_by
    ]
  )

  pg_search_scope :search_username,
    against: :username,
    :using => { :tsearch => {:prefix => true} }, # Buscar coincidencia desde las primeras letras.
    :ignoring => :accents # Ignorar tildes.

  pg_search_scope :search_by_fullname,
    :associated_against => { profile: [:first_name, :last_name] },
    :using => {:tsearch => {:prefix => true} }, # Buscar coincidencia desde las primeras letras.
    :ignoring => :accents # Ignorar tildes.

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/s
      # Ordenamiento por fecha de creación en la BD
      order("users.created_at #{ direction }")
    else
      # Si no existe la opcion de ordenamiento se levanta la excepcion
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_sector_id, lambda { |an_id|
    where(sector_id: [*an_id])
  }

  def full_name
    if self.profile.present?
      self.profile.full_name
    else
      self.username
    end
  end

  def name_and_sector
    self.full_name+" | "+self.sector.name
  end

  def sector_and_establishment
    self.sector_name+" "+self.establishment_name
  end
end
