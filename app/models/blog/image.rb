class Blog::Image < Asset
    has_attached_file :attachment,
    :styles => {
        :original => {source_file_options: '-auto-orient'},
        :new => {:geometry => "400x300#", :quality => 100, :format => 'jpg'},
        :thumb => {:geometry => "640x480#", :quality => 100, :format => 'jpg'}
        },:default_url => "img_not_available.png",
        :convert_options => {:all => "-quality 100"}
    validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"] }
end