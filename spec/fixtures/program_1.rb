class Song

  attr_accessor :title, :year, :artist, :options

  def initialize(title, year, artist, options={})
    self.title = title
    self.year = year
    self.artist = artist
    self.options = options
  end

  def can_be_playlisted?
    options[:available_to_playlist]
  end

  def can_be_downloaded?
    options.fetch[:downloadable]
  end

  def drm_enabled?
    options['drm_enabled']
  end

  def metadata
    {
      :playlist => can_be_playlisted?,
      :download => can_be_downloaded
    }
  end

end