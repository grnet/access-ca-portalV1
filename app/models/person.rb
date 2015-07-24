# -*- coding: utf-8 -*-
class Person < ActiveRecord::Base
  acts_as_versioned
  # This should be omitted in the english version
  validates_presence_of :first_name_el,
                        :on => :create,
                        :message => :first_name_el_blank
  validates_format_of   :first_name_el,
                        :with => /^[Α-Ωα-ωά-ώΆ-Ώ\-]*$/,
                        :message => :first_name_el_invalid
  validates_presence_of :first_name_en,
                        :message => :first_name_en_blank
  validates_format_of   :first_name_en,
                        :with =>/^[A-Za-z\-\']*$/,
                        :message => :first_name_el_invalid
  # This should be omitted in the english version
  validates_presence_of :last_name_el,
                        :message => :last_name_el_blank
  validates_format_of   :last_name_el,
                        :with =>/^[Α-Ωα-ωά-ώΆ-Ώ\-]*$/,
                        :message => :last_name_el_invalid
  validates_presence_of :last_name_en,
                        :message => :last_name_en_blank
  validates_format_of   :last_name_en,
                        :with =>/^[A-Za-z\-\']*$/,
                        :message => :last_name_en_invalid
  validates_presence_of :work_phone,
                        :message => :work_phone_blank
  validates_presence_of :email,
                        :message => :email_blank
  validates_length_of   :first_name_el, :first_name_en, :last_name_el, :last_name_en, :email, :department,
                        :on => :create,
                        :maximum => 254,
                        :message => :too_long
 validates_uniqueness_of  :email,
                          :message => :email_taken
  validates_numericality_of :work_phone,
                            :message => :work_phone_other_than
  validates_as_email    :email,
                        :message => :email_invalid
                      
  has_many :personal_requests,
           :class_name => "CertificateRequest",
           :as => :owner
  has_many :requested_certificate_requests,
           :class_name => "CertificateRequest",
           :foreign_key => :requestor_id
  has_many :distinguished_names,
           :as => :owner
  has_many :certificate_requests,
           :as => :owner
  has_many :host_administration_requests
  
  has_many :certificates,
           :as => :owner
  has_one :personal_certificate,
          :class_name => "Certificate",
          :as => :owner,
          :conditions => "created_at > to_timestamp(#{Time.now.last_year.strftime("%Y-%m-%d")}) and status = 'valid'",
          :order => 'created_at DESC'
  has_one :active_personal_csr,
          :class_name => "CertificateRequest",
          :foreign_key => "owner_id",
          :conditions => "owner_type='Person' and (status = 'pending' or status = 'approved')",
          :order => "created_at DESC"
  has_one :last_signed_certificate,
          :class_name => "Certificate",
          :as => :owner,
          :conditions => "created_at > to_timestamp(#{Time.now.last_year.strftime("%Y-%m-%d")}) and (status = 'valid' or status = 'not_accepted')",
          :order => 'created_at DESC'
  has_many :ui_requests
  has_many :see_vo_requests
  has_many :nwchem_vo_requests
  has_many :prace_t1_requests
  belongs_to :organization
  belongs_to :scientific_field
  has_many :hosts,
           :foreign_key => "admin_id"
  has_many :ra_staff_memberships,
           :foreign_key => "member_id"
  belongs_to :id_check_by,
             :class_name => "Person",
             :foreign_key => "last_id_check_by"

  def validate
    @organizations = Organization.find(:all).map {|o| o.domain}
    @isInstitutional = 0
    @organizations.each do |o|
      if email =~ /#{o}/ || email =~ /cern\.ch/ || email =~ /upnet\.gr/
        @isInstitutional = 1
      end
    end
#    if @isInstitutional < 1
#      errors.add(:email, "^ Η διεύθυνση e-mail πρέπει να είναι ιδρυματική")
#    end
    

    tablename = []
    self.first_name_en.split("-").each do |tmp1|
      tablename << tmp1.capitalize
    end
    if self.first_name_en != tablename.join("-")
      errors.add(:first_name_en, "#{I18n.t "activerecord.errors.models.person.first_letter_name_capital"}")
    end
    tablename = []
    self.first_name_el.split("-").each do |tmp1|
      tablename << tmp1.capitalize
    end
    if self.first_name_el != tablename.join("-")
      errors.add(:first_name_el, "#{I18n.t "activerecord.errors.models.person.first_letter_name_capital"}")
    end
    tablename = []
    self.last_name_en.split("-").each do |tmp1|
      tablename << tmp1.capitalize
    end
    if self.last_name_en != tablename.join("-")
      errors.add(:last_name_en, "#{I18n.t "activerecord.errors.models.person.first_letter_surname_capital"}")
    end
    tablename = []
    self.last_name_el.split("-").each do |tmp1|
      tablename << tmp1.capitalize
    end
    if self.last_name_el != tablename.join("-")
      errors.add(:last_name_el, "#{I18n.t "activerecord.errors.models.person.first_letter_surname_capital"}")
    end
  end
  
  def self.find_all_by_unconfirmed_email
    find  :all,
          :conditions => ["email_confirmation = 0 and created_at > ?", 10.days.ago],
          :order => "created_at ASC"
  end
  
  def self.find_by_confirmed_email(email)
    find  :first,
          :conditions => ["email_confirmation = 1 and email = ?", email]
  end
  
  def self.find_by_dn(dn)
    @dn = DistinguishedName.find :first, :conditions => ["subject_dn = ?", dn], :order => "created_at DESC"
    find(:first, :conditions => ["id = ?", @dn.owner_id])
  end
end
