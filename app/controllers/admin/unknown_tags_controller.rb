module Admin 
  class UnknownTagsController < ApplicationController
    
    before_action only: [:update, :index, :destroy] { is_authorized?('edit_publishers') }
    
    # GET /admin/unknown_tags
    # ----------------------------------------------------
    def index
      @sort = params[:sort] ||= 'value'
      @dir = params[:dir] ||= 'asc'
      
      @unknown_tags = UnknownTag.where(active: true).includes(:publisher).order("#{@sort.to_sym}": @dir.to_sym)
      @categories = Category.all.order(:name)
    end
  
    # PUT /admin/unknown_tags/[:id]
    # ----------------------------------------------------
    def update
      @unknown_tag = UnknownTag.find(params[:id])
    
      if params[:_json].size > 0
        # Turn the UnknownTag into a Tag and attach it to each of the categories specified
        tag = Tag.create(name: @unknown_tag.value)
        
        params[:_json].each do |hash|
puts "k: #{hash.keys[0]}, v: #{hash[hash.keys[0]]}"
          cat = Category.find(hash[hash.keys[0]])

puts cat.inspect
          if (cat && tag)
            cat.tags << tag
            cat.save
          end
        end
    
        # Deactivate the UnknownTag
        if @unknown_tag.update(active: false)
          respond_to do |format|
            format.json {render json: {msg: 'Tag has been categorized.'}}
          end
        end
      else
        respond_to do |format|
          format.json {render status: :bad_request, json: {msg: 'No categories selected.'}}
        end
      end
    end
  
    # DELETE /admin/unknown_tags/[:id]
    # ----------------------------------------------------
    def destroy
      unknown_tag = UnknownTag.find(params[:id])
      if unknown_tag.update(active: false)
        respond_to do |format|
          format.json {render json: {msg: 'We will now ignore that tag.'}}
        end
      end
    end
  end
end