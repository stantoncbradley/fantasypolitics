class AddFieldsToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :bioguide_id, :string
    add_column :politicians, :in_office, :boolean
    add_column :politicians, :govtrack_id, :string
    add_column :politicians, :crp_id, :string
    add_column :politicians, :gender, :string
    add_column :politicians, :birthday, :date
    add_column :politicians, :leadership_role, :string
    add_column :politicians, :term_start, :date
    add_column :politicians, :term_end, :date
    add_column :politicians, :state_name, :string
    add_column :politicians, :title, :string
    add_column :politicians, :chamber, :string
    add_column :politicians, :phone, :string
    add_column :politicians, :fax, :string
    add_column :politicians, :website, :string
    add_column :politicians, :office, :string
    add_column :politicians, :contact_form, :string
    add_column :politicians, :oc_email, :string
    add_column :politicians, :ocd_id, :string
  end
end
