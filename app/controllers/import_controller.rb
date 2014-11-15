# This is full of hacky utilities to import data fom the Sunlight 
# Congress API.
#
class ImportController < ApplicationController
  require 'sunlight_api'



  @will_import = false
  before_action :check_intent



  def check_intent
    warning_message = "Are you sure? Flip the switch in `app/controllers/import_controller.rb`..."
    render :text => warning_message and return unless @will_import 
  end



  def legislators
    resp          = Sunlight.call_api("legislators", 1)
    resp[:pages]  = (resp[:count] / 20.0).ceil
    results       = Array.new

    (1..resp[:pages]).each do |page|
      results += Sunlight.call_api("legislators", page).symbolize_keys[:results]
    end

    results.each do |legislator|
      Politician.create(
        first_name: legislator["first_name"],
        last_name: legislator["last_name"],
        in_office: legislator["in_office"],
        state: legislator["state"],
        state_name: legislator["state_name"],
        gender: legislator["gender"],
        bioguide_id: legislator["bioguide_id"],
        govtrack_id: legislator["govtrack_id"],
        party: legislator["party"],
        crp_id: legislator["crp_id"],
        birthday: legislator["birthday"].to_date,
        leadership_role: legislator["leadership_role"],
        term_start: legislator["term_start"].to_date,
        term_end: legislator["term_end"].to_date,
        title: legislator["title"],
        chamber: legislator["chamber"],
        phone: legislator["phone"],
        fax: legislator["fax"],
        website: legislator["website"],
        office: legislator["office"],
        contact_form: legislator["contact_form"],
        oc_email: legislator["oc_email"],
        ocd_id: legislator["ocd_id"],
      )
    end

    render :json => results 
  end
end
