class PeopleController < ApplicationController
  def new
    @action_title = "#{I18n.t "controllers.people.user_registration_form"}"
    scientific_fields = ScientificField.find(:all)
    # organizations = Organization.find(:all,:order => "name_el ASC")
    if params[:locale] == "el"
      organizations = Organization.find(:all,:order => "name_el ASC").map {|o| [truncate(o.name_el, 40), o.id]}
    else
      organizations = Organization.find(:all,:order => "name_en ASC").map {|o| [truncate(o.name_en, 40) || truncate(o.name_el, 40), o.id]}
    end
    render_comatose :page=>"person/new", :locals=>{:organizations=>organizations, :scientific_fields=>scientific_fields}, :layout => true
  end
end
