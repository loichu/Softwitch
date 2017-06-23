class Version < ApplicationRecord
  belongs_to :software

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :operating_systems
  has_and_belongs_to_many  :pcs


  # HANDLE THIS FUCKING SHIT !!!!!
  # Debug:
  # @compat_os: #<ActiveRecord::Relation [#<OperatingSystem id: 4, name: "Windows", created_at: "2017-06-21 08:59:07", updated_at: "2017-06-21 08:59:22">, #<OperatingSystem id: 5, name: "Linux", created_at: "2017-06-21 08:59:09", updated_at: "2017-06-21 08:59:24">]>
  # os : [#<OperatingSystem id: nil, name: "Windows">, #<OperatingSystem id: nil, name: "Linux">]
  def check_linux
    os = check_compat
    (os.include? 'Linux') ? '1' : '0'
  end

  def check_windows
    os = check_compat
    (os.include? 'Windows') ? '1' : '0'
  end

  def check_mac
    os = check_compat
    logger.debug @compat_os.inspect
    logger.debug os.inspect
    (os.include? 'Mac') ? '1' : '0'
  end

  def check_compat
    @os = OperatingSystem.all
    @compat_os = @os.where('operating_systems.id' => self.operating_systems.each(&:id))
    os = @compat_os.select(:name).to_a
    os
  end
end
