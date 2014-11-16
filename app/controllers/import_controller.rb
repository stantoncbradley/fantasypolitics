# This is full of hacky utilities to import data fom the Sunlight 
# Congress API.
#
class ImportController < ApplicationController
  require 'sunlight_api'



  WILL_IMPORT = true
  before_action :check_intent



  def check_intent
    warning = "Are you sure? Flip the switch in `app/controllers/import_controller.rb`..."
    render :text => warning and return unless WILL_IMPORT
  end



  def sunlight
    method = params[:method]
    case method
    when "legislators"
      import_legislators
    when "bills"
      import_bills
    when "votes"
      import_votes
    when "cosponsors"
      import_cosponsors
    end


  end

  private



  def import_legislators
    # Sample response format: 
    #
    # "bioguide_id":"B001280"
    # "birthday":"1951-10-06"
    # "chamber":"house"
    # "contact_form":"https://bentivolio.house.gov/contact/email-me"
    # "crp_id":"N00033625"
    # "district":11
    # "facebook_id":"316865541750741"
    # "fax":null
    # "fec_ids":["H2MI11133"]
    # "first_name":"Kerry"
    # "gender":"M"
    # "govtrack_id":"412547"
    # "icpsr_id":21336
    # "in_office":true
    # "last_name":"Bentivolio"
    # "middle_name":"L."
    # "name_suffix":null
    # "nickname":null
    # "oc_email":"Rep.Bentivolio@opencongress.org"
    # "ocd_id":"ocd-division/country:us/state:mi/cd:11"
    # "office":"226 Cannon House Office Building"
    # "party":"R"
    # "phone":"202-225-8171"
    # "state":"MI"
    # "state_name":"Michigan"
    # "term_end":"2015-01-03"
    # "term_start":"2013-01-03"
    # "thomas_id":"02135"
    # "title":"Rep"
    # "twitter_id":"RepKerryB"
    # "votesmart_id":123059
    # "website":"http://bentivolio.house.gov"
    # "youtube_id":"repkerry"
    #
    resp          = Sunlight.call_api("legislators", 1)
    resp[:pages]  = (resp[:count] / 50.0).ceil
    results       = Array.new


    (1..resp[:pages]).each do |page|
      results += Sunlight.call_api("legislators", page)[:results]
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



  def import_bills
    # Sample response format:
    #
    # "bill_id":"hres735-113"
    # "bill_type":"hres"
    # "chamber":"house"
    # "committee_ids":["HSFA"]
    # "congress":113
    # "cosponsors_count":14
    # "enacted_as":null
    # "history":{"active":false
    # "awaiting_signature":false
    # "enacted":false
    # "vetoed":false}
    # "introduced_on":"2014-09-18"
    # "last_action_at":"2014-09-18"
    # "last_version":{"version_code":"ih"
    # "issued_on":"2014-09-18"
    # "version_name":"Introduced in House"
    # "bill_version_id":"hres735-113-ih"
    # "urls":{"html":"http://www.gpo.gov/fdsys/pkg/BILLS-113hres735ih/html/BILLS-113hres735ih.htm"
    # "pdf":"http://www.gpo.gov/fdsys/pkg/BILLS-113hres735ih/pdf/BILLS-113hres735ih.pdf"
    # "xml":"http://www.gpo.gov/fdsys/pkg/BILLS-113hres735ih/xml/BILLS-113hres735ih.xml"}
    # "pages":3}
    # "last_version_on":"2014-09-18"
    # "last_vote_at":null
    # "number":735
    # "official_title":"Expressing the sense of the House of Representatives that recently proposed measures that will reduce transparency and public participation at the International Association of Insurance Supervisors (IAIS) should be disapproved by United States representatives to the IAIS."
    # "popular_title":null
    # "related_bill_ids":["sres561-113"]
    # "short_title":null
    # "sponsor":{"first_name":"Bill"
    # "last_name":"Huizenga"
    # "middle_name":null
    # "name_suffix":null
    # "nickname":null
    # "title":"Rep"}
    # "sponsor_id":"H001058"
    # "urls":{"congress":"http://beta.congress.gov/bill/113th/house-resolution/735"
    # "govtrack":"https://www.govtrack.us/congress/bills/113/hres735"
    # "opencongress":"http://www.opencongress.org/bill/hres735-113"}
    # "withdrawn_cosponsors_count":0
    #
    # Schema:
    # t.string   "committee"
    # t.boolean  "passed"
    # t.datetime "created_at"
    # t.datetime "updated_at"
    # t.string   "bill_number"
    # t.string   "chamber"
    # t.integer  "cosponsors_count"
    # t.string   "enacted_as"
    # t.date     "introduced_on"
    # t.date     "last_action_at"
    # t.date     "last_vote_at"
    # t.integer  "number"
    # t.string   "official_title"
    # t.string   "sponsor_id" 
    #
    resp          = Sunlight.call_api("bills", 1)
    resp[:pages]  = (resp[:count] / 50.0).ceil
    results       = Array.new


    puts resp[:pages] and return
    (1..resp[:pages]).each do |page|
      results += Sunlight.call_api("bills", page)[:results]
    end

    results.each do |bill|
      Bill.create(
        passed: bill["history"]["enacted"],
        bill_number: bill["bill_id"],
        chamber: bill["chamber"],
        cosponsors_count: bill["bill_id"],
        enacted_as: bill["enacted_as"],
        introduced_on: bill["introduced_on"].to_date,
        last_action_at: bill["last_action_at"].to_date,
        official_title: bill["official_title"],
        sponsor_id: bill["sponsor_id"]
      )
    end

    render :json => results 
  end



  def import_votes
    # Sample response format:
    #
    # "amendment_id":"hamdt1138-113"
    # "bill_id":"hr5078-113"
    # "chamber":"house"
    # "congress":113
    # "number":486
    # "question":"On Agreeing to the Amendment"
    # "required":"1/2"
    # "result":"Failed"
    # "roll_id":"h486-2014"
    # "roll_type":"On Agreeing to the Amendment"
    # "source":"http://clerk.house.gov/evs/2014/roll486.xml"
    # "url":"http://clerk.house.gov/evs/2014/roll486.xml"
    # "vote_type":"amendment"
    # "voted_at":"2014-09-09T21:02:00Z"
    # "year":2014
    #
    # Schema:
    #
    # t.string :ammendment_number
    # t.string :bill_number
    # t.string :chamber
    # t.integer :number
    # t.string :question
    # t.string :required
    # t.string :result
    # t.string :vote_type
    # t.date :voted_at
    # t.string :year
    #
    resp          = Sunlight.call_api("votes", 1)
    resp[:pages]  = (resp[:count] / 50.0).ceil
    results       = Array.new


    (1..resp[:pages]).each do |page|
      results += Sunlight.call_api("votes", page)[:results]
    end

    results.each do |vote|
      Vote.create(
        ammendment_number: vote["ammendment_number"],
        bill_number: vote["bill_number"],
        chamber: vote["chamber"],
        number: vote["number"],
        question: vote["question"],
        required: vote["required"],
        result: vote["result"],
        vote_type: vote["vote_type"],
        voted_at: vote["voted_at"].to_date,
        year: vote["year"]
      )
    end

    render :json => results    
  end



  def import_cosponsors
    # Same response format:
    #
    # "bill_id":"hres752-113"
    # "cosponsor_ids":[]

    # "bill_id":"hres751-113"
    # "cosponsor_ids":["C001080"
    # "F000010"
    # "H001034"
    # "L000551"
    # "M001160"
    # "N000179"
    # "S001177"
    # "S001175"
    # "T000468"
    # "V000081"]
    #
    # Schema:
    # t.integer "politician_id"
    # t.string  "bill_id" 
    #
    resp          = Sunlight.get_cosponsors("bills", 1)
    resp[:pages]  = (resp[:count] / 50.0).ceil
    results       = Array.new

    puts results

    (1..resp[:pages]).each do |page|
      results += Sunlight.get_cosponsors("bills", page)[:results]
    end
    politician_ids = Array.new
    politicians    = Array.new

    results.each do |sunlight_bill|
      puts sunlight_bill.inspect
      politicians    = []
      politician_ids = []
      bill           = Bill.find_by(bill_number: sunlight_bill["bill_id"])
      politician_ids = sunlight_bill["cosponsor_ids"]
      next unless politician_ids.present?

      politician_ids.each do |p_id|
        politicians << Politician.find_by(bioguide_id: p_id)
      end

      politicians.each do |p|
        if p.id.present? and bill.id.present?
          Sponsor.create(
            bill_id: bill.id,
            politician_id: p.id
          )
        end
      end
    end

    render :json => results  

  end



end
