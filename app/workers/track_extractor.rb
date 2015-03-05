require 'hypem'

class TrackExtractor
  def self.perform(options = {})
    username = options[:hypem_username] || "s2t2unes"
    track_counter = 0

    user = Hypem.user(username)
    playlist = user.loved_playlist
    page = playlist.page(1)
    tracks = page.tracks

    tracks.each do |t|
      #<Hypem::Track:0x007ff84b77ff60
      #  @artist="Purity Ring",
      #  @date_posted=Wed, 04 Mar 2015 05:24:32 -0800,
      #  @dateloved=1425410448,
      #  @description= "The release of a sophomore album for a highly buzzed, electro-pop act can be a dicey game. If the new material veers too close to true “pop”, the the fan base might cry foul. If it swings the other way, it could suffer too much from “sameness” or lose the",
      #  @itunes_link="http://hypem.com/go/itunes_search/Purity%20Ring",
      #  @loved_count=12095,
      #  @media_id="28t6h",
      #  @post_id=2635672,
      #  @post_url="http://therevue.ca/2015/03/04/purity-ring-another-eternity/",
      #  @posted_count=27,
      #  @site_id=22227,
      #  @site_name="The Revue",
      #  @thumb_url="http://static.hypem.net/thumbs_new/98/2635672.jpg",
      #  @thumb_url_artist=nil,
      #  @thumb_url_large="http://static.hypem.net/thumbs_new/3e/2635070_320.jpg",
      #  @thumb_url_medium="http://static.hypem.net/thumbs_new/98/2635672_120.jpg",
      #  @time=217,
      #  @title="begin again"
      #>

      track = {
        :loved_at => t.dateloved,
        :loved_count => t.loved_count,

        :media_id => t.media_id,
        :name => t.title,
        :artist_name => t.artist,
        :duration => t.time,

        :site_id => t.site_id,
        :site_name => t.site_name,

        :post_id => t.post_id,
        :post_url => t.post_url,
        :posted_count => t.posted_count,
        :post_description => t.description,
        :posted_at => t.date_posted,

        :thumb_url => t.thumb_url,
        :thumb_url_large => t.thumb_url_large,
        :thumb_url_medium => t.thumb_url_medium,
        :thumb_url_artist => t.thumb_url_artist,

        :itunes_url => t.itunes_link
      }

      track_counter +=1

      pp "#{track_counter} -- #{track[:name]}"
    end

    p2 = playlist.next_page
    p2.tracks.first.title

    binding.pry
  end
end
