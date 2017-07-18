class Version < ApplicationRecord
  belongs_to :software

  has_and_belongs_to_many :tags
  has_and_belongs_to_many :operating_systems

  has_many :pcs, through: :installations
  #has_and_belongs_to_many  :pcs

  after_save :update_software
  after_update :update_software

  def check_linux(compat)
    (compat.include? 'Linux') ? '1' : '0'
  end

  def check_windows(compat)
    (compat.include? 'Windows') ? '1' : '0'
  end

  def check_mac(compat)
    (compat.include? 'Mac') ? '1' : '0'
  end

  def check_compat
    compat_os = Array.new
    @os = OperatingSystem.all

    @compat_os = @os.where('operating_systems.id' => self.operating_systems.each(&:id))

    os = @compat_os.select(:name).to_a

    os.each do |os|
      compat_os.push os.name
    end

    compat_os
  end

  def update_software
    @software = Software.find(self.software.id)
    @software.check_compatibility
  end
end
