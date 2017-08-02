class Program < ApplicationRecord
  belongs_to :editor
  has_many :versions, dependent: :destroy

  # TODO:
  # If no version: delete soft

  def check_compatibility
    linux = '0'
    windows = '0'
    mac = '0'

    versions.each do |v|
      compat = v.check_compat
      linux = v.check_linux(compat)
      windows = v.check_windows(compat)
      mac = v.check_mac(compat)
    end

    compatibility = linux + windows + mac
    update compatibility: compatibility
  end
end
