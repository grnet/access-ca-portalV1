class RegistrationMailer < ActionMailer::Base

  def confirmation_of_email_address(person, email_confirmation_hash, confirmation_url, rejection_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "HellasGrid Email Confirmation for " + person.email
    @recipients = person.email
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["person"] = person
    @body["email_confirmation_hash"] = email_confirmation_hash
    @body["confirmation_url"] = confirmation_url
    @body["rejection_url"] = rejection_url
  end
  
  def confirm_ownership_of_email_address(person, email_confirmation_hash, confirmation_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "HellasGrid Email Confirmation for " + person.email
    @recipients = person.email
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["person"] = person
    @body["email_confirmation_hash"] = email_confirmation_hash
    @body["confirmation_url"] = confirmation_url
  end

  def notification_of_csr_submition_to_ra(person, csr, csr_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
     if csr.owner_type == "Person"
       @subject = "HellasGrid CA certificate request for: " + csr.owner.email
     else
       csrReader = X509Certificate::RequestReader.new(csr.body)
       csrReader.request[:dnElements].each_value do |dnEl|
         if dnEl['Type']=="CN" 
           if dnEl['Value'].include?("/")
             @body["fqdn"] = dnEl['Value'].split("/")[1]
           else
             @body["fqdn"] = dnEl['Value']
           end
         end
       end
       @subject = "HellasGrid CA certificate request for: " + @body["fqdn"]
     end
     @recipients = ""
     @bcc = RegistrationAuthority.find(1).email
     csr.organization.registration_authorities.each {|o|
       o.ra_staff_memberships.each {|p|
         @recipients += p.member.email + ", " 
       }
     }
     @recipients = @recipients.chop.chop
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["csr"] = csr
     @body["csr_url"] = csr_url
  end
  
  def notification_of_csr_submition_to_ca_no_ra(person, csr, csr_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "HellasGrid CA certificate request for: " + csr.owner.email
     @recipients = "hellasgrid-ca@grid.auth.gr"
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["csr"] = csr
     @body["csr_url"] = csr_url
  end
  
  def notification_of_csr_submition_to_user(person, csr_status_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "Your certificate request has been submitted to the HellasGrid CA"
     @recipients = person.email
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @ra_info = ""
     person.active_personal_csr.organization.registration_authorities.each {|o|
       @ra_info += o.description + ", " 
     }
     @body["ra_info"] = @ra_info.chop.chop
     @body["person"] = person
     @body["csr_status_link"] = csr_status_link
  end
  
  def notification_of_csr_submition_to_user_no_ra(person, csr_status_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "Your certificate request has been submitted to the HellasGrid CA"
     @recipients = person.email
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["csr_status_link"] = csr_status_link
  end

  def notification_of_host_csr_submition_to_user(admin, cert_request, csr_status_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     csrReader = X509Certificate::RequestReader.new(cert_request.body)
     csrReader.request[:dnElements].each_value do |dnEl|
       if dnEl['Type']=="CN" 
         if dnEl['Value'].include?("/")
           @body["fqdn"] = dnEl['Value'].split("/")[1]
         else
           @body["fqdn"] = dnEl['Value']
         end
       end
     end
     @subject = "HellasGrid CA certificate request for: " + @body["fqdn"]
     @recipients = admin.email
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @ra_info = ""
     cert_request.organization.registration_authorities.each {|o|
       @ra_info += o.description + ", " 
     }
     @body["ra_info"] = @ra_info.chop.chop
     @body["admin"] = admin
     @body["cert_request"] = cert_request
     @body["csr_status_link"] = csr_status_link
  end
  
  def notification_of_csr_renewal_to_user(person, csr_status_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "Your certificate request has been submitted to the HellasGrid CA"
     @recipients = person.email
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["csr_status_link"] = csr_status_link
  end

  def notification_of_csr_renewal_to_ra(person, csr, csr_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
     if csr.owner_type == "Person"
       @subject = "HellasGrid CA certificate request for: " + csr.owner.email
     else
       csrReader = X509Certificate::RequestReader.new(csr.body)
       csrReader.request[:dnElements].each_value do |dnEl|
         if dnEl['Type']=="CN" 
           if dnEl['Value'].include?("/")
             @body["fqdn"] = dnEl['Value'].split("/")[1]
           else
             @body["fqdn"] = dnEl['Value']
           end
         end
       end
       @subject = "HellasGrid CA certificate request for: " + @body["fqdn"]
     end
     @recipients = ""
     @bcc = RegistrationAuthority.find(1).email
     csr.organization.registration_authorities.each {|o|
       o.ra_staff_memberships.each {|p|
         @recipients += p.member.email + ", " 
       }
     }
     @recipients = @recipients.chop.chop
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["csr"] = csr
     @body["csr_url"] = csr_url
  end  
  
  def notification_of_new_certificate_to_user(requestor, crt, get_cert_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     if crt.owner_type == "Person"
       @subject = "HellasGrid CA certificate for: " + crt.owner.email
     else
       crtReader = X509Certificate::CertificateReader.new(crt.body)
       crtReader.certificate[:dnElements].each_value do |dnEl|
         if dnEl['Type']=="CN" 
           if dnEl['Value'].include?("/")
             @body["fqdn"] = dnEl['Value'].split("/")[1]
           else
             @body["fqdn"] = dnEl['Value']
           end
         end
       end
       @subject = "HellasGrid CA certificate for: " + @body["fqdn"]
     end
     @recipients = requestor.email
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["crt"] = crt
     @body["get_cert_link"] = get_cert_link
     @body["altnames"] = ""
     crt.alternative_names.each {|altname|
       if altname.alt_name_type == "email"
         @body["altnames"] = @body["altnames"] + "              E-mail: " +altname.alt_name_value + "\n"
       else
         @body["altnames"] = @body["altnames"] + "                 DNS: " +altname.alt_name_value + "\n"
       end
     }
  end

  def notification_of_new_certificate_to_ra(requestor, crt, get_cert_link)
    @headers['Content-Transfer-Encoding'] = "8bit"
     if crt.owner_type == "Person"
       @subject = "HellasGrid CA certificate for: " + crt.owner.email
     else
       crtReader = X509Certificate::CertificateReader.new(crt.body)
       crtReader.certificate[:dnElements].each_value do |dnEl|
         if dnEl['Type']=="CN" 
           if dnEl['Value'].include?("/")
             @body["fqdn"] = dnEl['Value'].split("/")[1]
           else
             @body["fqdn"] = dnEl['Value']
           end
         end
       end
       @subject = "HellasGrid CA certificate for: " + @body["fqdn"]
     end
     @recipients = ""
     crt.owner.organization.registration_authorities.each {|o|
       if o.email == "hg-auth-ra@grid.auth.gr"
         @bcc = o.email 
       end
       o.ra_staff_memberships.each {|p|
         @recipients += p.member.email + ", " 
       }
     }
     @recipients = @recipients.chop.chop
     @cc = "hellasgrid-ca@grid.auth.gr"
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["crt"] = crt
     @body["get_cert_link"] = get_cert_link
     @body["altnames"] = ""
     crt.alternative_names.each {|altname|
       if altname.alt_name_type == "email"
         @body["altnames"] = @body["altnames"] + "              E-mail: " +altname.alt_name_value + "\n"
       else
         @body["altnames"] = @body["altnames"] + "                 DNS: " +altname.alt_name_value + "\n"
       end
     }
  end
  
  def notification_of_ui_request(person, ui, recipients)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "Request for UI access"
     @recipients = recipients
     if ui == "HG-03-AUTH" then
       @bcc = "support@grid.auth.gr"
     else
       @bcc = "team@grid.auth.gr"
     end
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["person"] = person
     @body["ui"] = ui
  end
  
  def notification_of_ui_request_to_user(person)
      @headers['Content-Transfer-Encoding'] = "8bit"
      @subject = "UI request acknowledged"
      @recipients = person.email
      @charset = "utf-8"
      @from = "support@grid.auth.gr"
      @body["person"] = person
  end

  def notification_of_see_vo_request(person, recipients)
    @headers['Content-Transfer-Encoding'] = "8bit"
     @subject = "Request for SEE VO membership"
     @recipients = recipients
     @charset = "utf-8"
     @from = "see-vo@grid.auth.gr"
     @body["person"] = person
  end
  
  def notification_of_see_vo_request_to_user(person)
      @headers['Content-Transfer-Encoding'] = "8bit"
      @subject = "Request for SEE VO membership acknowledged"
      @recipients = person.email
      @charset = "utf-8"
      @from = "see-vo@grid.auth.gr"
      @body["person"] = person
  end
  
  # def notification_of_nwchem_vo_request(person, recipients)
  #   @headers['Content-Transfer-Encoding'] = "8bit"
  #    @subject = "Request for nwchem VO membership"
  #    @recipients = recipients
  #    @charset = "utf-8"
  #    @from = "support@grid.auth.gr"
  #    @body["person"] = person
  # end
  #
  # def notification_of_prace_t1_request(person, recipients)
  #   @headers['Content-Transfer-Encoding'] = "8bit"
  #    @subject = "Access request for PRACE T1"
  #    @recipients = recipients
  #    @charset = "utf-8"
  #    @from = "support@grid.auth.gr"
  #    @body["person"] = person
  # end

  def notification_for_expiration(expire_in_a_week, expire_in_a_month)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "These certificates will expire soon"
    @recipients = "pkoro@grid.auth.gr"
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["expire_in_a_week"] = expire_in_a_week
    @body["expire_in_a_month"] = expire_in_a_month
  end
  
  def notification_of_user_certificate_expiration(crt,days)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "[HellasGrid CA] #{I18n.t "activerecord.models.registration_mailer.notification_of_user_certificate_expiration.subject"}" 
    @recipients = crt.owner.email
    @bcc = "team@grid.auth.gr"
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["crt"] = crt
    crtReader = CertificateReader.new(crt.body,"")
    @body["IssueDate"] = crtReader.certificate[:IssueDate].to_s
    @body["ExpirationDate"] = crtReader.certificate[:ExpirationDate].to_s
    @body["subjectDN"] = crtReader.certificate[:Subject].to_s
    @body["Serial"] = crtReader.certificate[:Serial].to_s
    @body["email"] = crt.owner.email
    @body["days"] = days
  end

  def notification_of_host_certificate_expiration(crt,days)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "[HellasGrid CA] #{I18n.t "activerecord.models.registration_mailer.notification_of_host_certificate_expiration.subject"} " + crt.owner.fqdn 
    @recipients = crt.owner.admin.email
    @bcc = "team@grid.auth.gr"
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["crt"] = crt
    crtReader = CertificateReader.new(crt.body,"")
    @body["IssueDate"] = crtReader.certificate[:IssueDate].to_s
    @body["ExpirationDate"] = crtReader.certificate[:ExpirationDate].to_s
    @body["subjectDN"] = crtReader.certificate[:Subject].to_s
    @body["Serial"] = crtReader.certificate[:Serial].to_s
    @body["email"] = crt.owner.admin.email
    @body["fqdn"] = crt.owner.fqdn
    @body["days"] = days
  end
  
  def notification_of_csr_approvement(csr, csr_url)
    @headers['Content-Transfer-Encoding'] = "8bit"
     if csr.owner_type == "Person"
       @subject = "HellasGrid CA certificate request for: " + csr.owner.email
     else
       csrReader = X509Certificate::RequestReader.new(csr.body)
       csrReader.request[:dnElements].each_value do |dnEl|
         if dnEl['Type']=="CN" 
           if dnEl['Value'].include?("/")
             @body["fqdn"] = dnEl['Value'].split("/")[1]
           else
             @body["fqdn"] = dnEl['Value']
           end
         end
       end
       @subject = "HellasGrid CA certificate request for: " + @body["fqdn"]
     end
     @recipients = "hellasgrid-ca@grid.auth.gr"
     @charset = "utf-8"
     @from = "support@grid.auth.gr"
     @body["csr"] = csr
     @body["csr_url"] = csr_url
  end
  
  def notification_of_pending_requests(pending_requests)
    @headers['Content-Transfer-Encoding'] = "8bit"
    @subject = "[HellasGrid CA] #{I18n.t "activerecord.models.registration_mailer.notification_of_pending_requests.subject"}"
    @recipients = "team@grid.auth.gr"
    @charset = "utf-8"
    @from = "support@grid.auth.gr"
    @body["pending_requests"] = pending_requests
  end
end
