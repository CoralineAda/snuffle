class Song

  attr_accessor :title, :year, :artist, :options

  def initialize(title, year, artist, options={})
    self.title = title
    self.year = year
    self.artist = artist
    self.options = options
  end

  def can_be_playlisted?
    metadata[:playlist]
  end

  def can_be_downloaded?
    metadata[:download]
  end

  def drm_enabled?
    options['drm_enabled']
  end

  def metadata
    {
      :playlist => options[:available_to_playlist],
      :download => options[:downloadable]
    }
  end

end