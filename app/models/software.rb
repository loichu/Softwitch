class Software < ApplicationRecord
  belongs_to :editor
  has_many :versions

  def check_compatibility
    linux = '0'
    windows = '0'
    mac = '0'

    versions.each do |v|
      linux = v.check_linux
      windows = v.check_windows
      mac = v.check_mac
    end
    logger.debug "Linux: #{linux}"
    logger.debug "Windows: #{linux}"
    logger.debug "Mac: #{linux}"
    compatibility = linux + windows + mac
    update :compatibility => compatibility
  end
end
