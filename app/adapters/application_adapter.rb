class ApplicationAdapter
  protected

  def agent
    @agent ||= Mechanize.new
  end
end
