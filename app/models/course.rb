class Course < ApplicationRecord

     include PgSearch
     pg_search_scope :search_by_name, :against => [:name]

     has_many :amenities
     has_many :holes
     has_one :location

     belongs_to :network
     belongs_to :resort

     has_many :score_cards
     belongs_to :admin
     has_many :reviews
     has_many :course_users
     has_many :users, through: :course_users

     accepts_nested_attributes_for :location, :allow_destroy => true
     accepts_nested_attributes_for :score_cards, :allow_destroy => true
     accepts_nested_attributes_for :holes, :allow_destroy => true
     accepts_nested_attributes_for :amenities, :allow_destroy => true
     validates_presence_of :name,:bio, :website, :phone_num, :total_par, :slope, :rating, :length

     has_attached_file :logo, styles: {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    }

    # Validate the attached image is image/jpg, image/png, etc
    validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

    has_attached_file :cover, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

   enum course_type: [ :is_public, :is_private, :is_semi_private ]

     def formated_location
          formated_location_result = ""
          town = self.location.try(:town)
          state = self.location.try(:state)
          lat = self.location.try(:lat)
          lng = self.location.try(:lng)

          formated_location_result << town  if town
          formated_location_result << ", " + state if state
          # formated_location_result << " " +  "(lat: #{ lat },lng: #{ lng })" if lat and lng

          formated_location_result
     end

     def resorts_names
          self.resorts.pluck(:name).join(',')
     end

     def networks_names
          self.networks.pluck(:name).join(',')
     end

     def amenities_list
       self.amenities.pluck(:name).join(',') rescue 'N/A'
     end
end
