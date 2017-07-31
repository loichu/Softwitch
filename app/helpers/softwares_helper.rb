module ProgramsHelper
  # Linux Windows Mac
  #  0      0      0


  def CheckAllCompatibility(softs)
    softs.each do |s|
      s.check_compatibility
    end
  end
end
