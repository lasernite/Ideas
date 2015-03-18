class AtagsController < ApplicationController
  respond_to :html, :js
  def new
  end

  def show
  	@atag = Atag.find_by_tag(params[:id])
  	# Get all unique posts with tag, store as @aposts
  	@aptags = @atag.ptags
  	@aposts = []
  	@aptags.each do |aptag|
  		@aposts.append(Post.find(aptag.post_id))
  		@aposts = @aposts.uniq
  	end

  	# So comments get passed to partial
  	@comments = Comment.all

  	# Build all aposts as items in @aposts_spliced, with each item an @apost_pieces array
  	@ptags = Ptag.all
  	@atags = Atag.all
  	@aposts_spliced = []
  	splice_posts(@aposts, @aposts_spliced)

    # Build all aposts for external community page (non-ajax)
    @aposts_spliced_full = []
    # Paginate posts first so only posts being loaded are spliced
    @aposts = @aposts.reverse.paginate(:page => params[:page], :per_page => 30)
    splice_posts_full(@aposts, @aposts_spliced_full)

    # Generate Related Tags
    @associated_ptags = []
    Ptag.where(tag:@atag.tag).each do |ptag|
      @associated_ptags.append(Ptag.where(post_id:ptag.post_id))
    end
    # Create Hash to Count Tag Relations
    @related_tags = Hash.new(0)
    @associated_ptags.each do |ptag_array|
      ptag_array.each do |ptag|
        @related_tags[ptag.tag] += 1
      end
    end
    # Order from most to least associated and take top twenty excluding current tag community
    @related_tags = @related_tags.sort_by {|tag,count| -count}
    @related_tags = @related_tags[1..20]
  end
end
