module Scanner
  class RssReader < Reader
    
    # -------------------------------------------------------------------
    def process(publisher, entry)
      content = (entry.content_encoded.nil? ? entry.description : entry.content_encoded)      
      date = entry.pubDate
      author = (entry.author.nil? ? entry.dc_creator.to_s : entry.author)
      categories, unknowns = [], []

      # If the RSS entry contains content, a publish date, a title and a link
      if content && date && entry.title && entry.link
        if entry.category.nil?
          category = detect_category(entry.dc_subject.to_s) unless entry.dc_subject.nil?
        else
          category = detect_category(entry.category.to_s)
        end
    
        if category.is_a?(UnknownTag)
          category.publisher = publisher
          category.save!
          
        elsif category.is_a?(Category)
          categories << category 
        end
        
        hash = detect_media_content(entry.description)
      
        article = Article.new(
          {target: entry.link, 
           title: entry.title, 
           author: (author ? clean_author(author) : nil), 
           publication_date: (date ? date : nil), 
           thumbnail: hash[:thumb],
           media: hash[:media],
           media_type: hash[:type],
           media_host: hash[:host],
           content: clean_html(strip_html(content)),
           categories: categories,
           publisher: publisher})
      end # no content, date, title and/or link
    end
    
    private
      # -------------------------------------------------------------------   
      def detect_category(tag)
        tag = strip_html(tag)
        category = Category.find_by(slug: tag.downcase.gsub(' ', '-'))
      
        if category.nil?
          category = UnknownTag.new(value: tag) if UnknownTag.find_by(value: tag).nil?
        end
      
        category
      end
    
  end
end  


# Example of response from normal RSS feed using Ruby's RSS library
# --------------------------------------------------------------------------
=begin
<RSS::Rss::Channel::Item:0x007ffb8afb4220 
	@parent=nil, 
	@converter=nil, 
	@do_validate=true, 
	@title="Astronauts: The sailors of outer space?", 	@link="http://www.zerotocruising.com/astronauts-long-distance-sailors-outer-space", 	@description="<p>After watching The Martian for the second time, some friends of ours recommended that Rebecca and I check out the book that it was based on, stating that it was even more captivating than the movie. Since we both thoroughly enjoyed the film, we followed through on the suggestion, and each started reading the book [&#8230;]</p>\n<p>The post <a rel=\"nofollow\" href=\"http://www.zerotocruising.com/astronauts-long-distance-sailors-outer-space\">Astronauts: The sailors of outer space?</a> appeared first on <a rel=\"nofollow\" href=\"http://www.zerotocruising.com\">Zero to Cruising</a>.</p>\n", 
	@source=nil, 
	@enclosure=nil, 	@comments="http://www.zerotocruising.com/astronauts-long-distance-sailors-outer-space#comments", 	@author=nil, 
	@pubDate=2016-12-05 10:30:38 +0000, 
	
	@guid=#<RSS::Rss::Channel::Item::Guid:0x007ffb8be7b768 
			@parent=nil, 
			@converter=nil, 
			@do_validate=true, 
			@isPermaLink=false, 
			@content="http://www.zerotocruising.com/?p=29879">, 
			
	@content_encoded=nil, 
	@itunes_author=nil, 
	@itunes_block=nil, 
	@itunes_explicit=nil, 
	@itunes_keywords=nil, 
	@itunes_subtitle=nil, 
	@itunes_summary=nil, 
	@itunes_name=nil, 
	@itunes_email=nil, 
	@itunes_duration=nil, 
	@trackback_ping=nil, 
	@category=[#<RSS::Rss::Channel::Item::Category:0x007ffb8be8d6e8 
										@parent=nil, 
										@converter=nil, 
										@do_validate=true, 
										@domain=nil, 
										@content="Featured">, 
						 #<RSS::Rss::Channel::Item::Category:0x007ffb8be83080 
						 				@parent=nil, 
										@converter=nil, 
										@do_validate=true, 
										@domain=nil, 
										@content="Making It Happen">], 
	@dc_title=[], 
	@dc_description=[], 
	@dc_creator=[#<RSS::DublinCoreModel::DublinCoreCreator:0x007ffb8be8f4e8 
									@parent=nil, 
									@converter=nil, 
									@do_validate=true, 
									@content="Mike Sweeney">], 
	@dc_subject=[], 
	@dc_publisher=[], 
	@dc_contributor=[], 
	@dc_type=[],
	@dc_format=[], 
	@dc_identifier=[], 
	@dc_source=[], 
	@dc_language=[], 
	@dc_relation=[], 
	@dc_coverage=[], 
	@dc_rights=[], 
	@dc_date=[], 
	@trackback_about=[]>
=end