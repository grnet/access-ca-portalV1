class AddEnglishNameForOrganizations < ActiveRecord::Migration
  def self.up
    Organization.find_each do |organization|
      case organization.name_el
      when "Ανωτάτη Σχολή Καλών Τεχνών"
        organization.name_en = "Athens School of Fine Arts"
      when "Ανωτέρα Εκκλησιαστική Σχολή Θεσσαλονίκης"
        organization.name_en = "Ecclesiastical School of Thessaloniki"
      when "Αριστοτέλειο Πανεπιστήμιο Θεσσαλονίκης"
        organization.name_en = "Aristotle University of Thessaloniki"
      when "ΑΣΠΑΙΤΕ"
        organization.name_en = "School of Pedagogical and Technological Education"
      when "Boυλή των Ελλήνων"
        organization.name_en = "Hellenic Parliament"
      when "Γενική Γραμματεία Έρευνας και Τεχνολογίας"
        organization.name_en = "General Secretariat for Research and Technology"
      when "Γενική Γραμματεία Πολιτικής Προστασίας"
        organization.name_en = "General Secretariat for Civil Protection"
      when "Γεωπονικό Πανεπιστήμιο Αθηνών"
        organization.name_en = "Agricultural University of Athens"
      when "Γεωργική και Βιοτεχνική Σχολή Θεσσαλονίκης"
        organization.name_en = "Thessalonica Agricultural and Industrial Institute"
      when "Δημοκρίτειο Πανεπιστήμιο Θράκης"
        organization.name_en = "Democritus University of Thrace"
      when "Διαχείριση ΕΔΕΤ"
        organization.name_en = "Greek Research & Technology Network"
      when "Διεθνές κέντρο Δημόσιας Διοίκησης"
        organization.name_en = nil
      when "Δίκτυο Σύζευξις"
        organization.name_en = "SYZEFXIS"
      when "ΕΚΕΒΕ Α. Φλέμιγκ"
        organization.name_en = "Alexander Fleming Biomedical Sciences Research Center"
      when "Ε.ΚΕ.ΦΕ Δημόκριτος"
        organization.name_en = "NCSR Demokritos"
      when "Εθνικό Αστεροσκοπείο Αθηνών"
        organization.name_en = "National Observatory of Athens"
      when "Εθνικό και Καποδιστριακό Πανεπιστήμιο Αθηνών"
        organization.name_en = "National and Kapodistrian University of Athens"
      when "Εθνικό Κέντρο Δημόσιας Διοίκησης"
        organization.name_en = "National Centre for Public Administration and Local Government"
      when "Εθνικό Κέντρο Διαβήτη"
        organization.name_en = nil
      when "Εθνικό Κέντρο Θαλάσσιας Ερευνας"
        organization.name_en = "Hellenic Centre for Marine Research"
      when "Εθνικό Κέντρο Τεκμηρίωσης / EIE"
        organization.name_en = "National Documentation Centre"
      when "Εθνικό Μετσόβιο Πολυτεχνείο"
        organization.name_en = "National Technical University of Athens"
      when "ΕΙΧΗΜΥΘ"
        organization.name_en = "Institute of Chemical Engineering Sciences"
      when "EKETA/Ινστιτούτο Αγροβιοτεχνολογίας"
        organization.name_en = "Centre for Research and Technology-Hellas (CERTH)"
      when "Ελληνικό Ανοιχτό Πανεπιστήμιο"
        organization.name_en = "Hellenic Open University"
      when "Ελληνικός Οργανισμός Τυποποίησης"
        organization.name_en = "ELOT"
      when "Ευρωπαϊκό Κέντρο για την Ανάπτυξη της Επαγγελματικής Κατάρτισης"
        organization.name_en = "Cedefop (European Centre for the Development of Vocational Training)"
      when "Ερευνητικό Ακαδημαϊκό Ινστιτούτου Τεχνολογίας Υπολογιστών"
        organization.name_en = "CTI (Computer Technology Institute)"
      when "ΙΑΣΑ"
        organization.name_en = "IASA"
      when "Ίδρυμα Ευγενίδου"
        organization.name_en = "Eugenides Foundation"
      when "Ίδρυμα Ιατροβιολογικής Έρευνας Ακαδημίας Αθηνών"
        organization.name_en = "Biomedical Research Foundation of the Academy of Athens"
      when "Ιδρυμα Τεχνολογίας  Ερευνας"
        organization.name_en = "Foundation for Research and Technology-Hellas (FORTH)"
      when "Ινστ. Pasteur"
        organization.name_en = "Hellenic Pasteur Institute"
      when "Ινστ. Γεωλογικών & Μεταλλευτικών Ερευνών"
        organization.name_en = "IGME"
      when "Ινστ. Επεξεργασίας Λόγου"
        organization.name_en = "Institute for Language and Speech Processing"
      when "Ινστιτούτο Θαλάσσιας Βιολογίας"
        organization.name_en = "Hellenic Centre for Marine Research"
      when "Ινστιτούτο Πολιτιστικής & Εκπαιδευτικής Τεχνολογίας"
        organization.name_en = "Cultural and Educational Technology Institute"
      when "Ινστιτούτο Τεχνικής Σεισμολογίας & Αντισεισμικών Κατασκευών"
        organization.name_en = "Institute of Engineering Seismology and Earthquake Engineering"
      when "Ιόνιο Πανεπιστήμιο"
        organization.name_en = "Ionian University"
      when "Κέντρο Ανανεώσιμων Πηγών Ενέργειας"
        organization.name_en = "Centre for Renewable Energy Sources and Saving (CRES)"
      when "Κέντρο Ερευνας για Θέματα Ισότητας"
        organization.name_en = nil
      when "Κέντρο Ελληνικής Γλώσσας"
        organization.name_en = nil
      when "Κέντρο Ερευνών ΝΕΣΤΩΡ"
        organization.name_en = "NESTOR"
      when "Οικονομικό Πανεπιστήμιο Αθηνών"
        organization.name_en = "Athens University of Economics and Business"
      when "Οργανισμός Αντισεισμικής Προστασίας"
        organization.name_en = nil
      when "ΟΤΕ – Συγκρότημα Εργαστηρίων Νέων Τεχνολογιών & Υπηρεσιών"
        organization.name_en = "OTE"
      when "Πανελλήνιο Σχολικό Δίκτυο – EDUnet"
        organization.name_en = "EDUnet"
      when "Πανεπιστήμιο Αιγαίου"
        organization.name_en = "University of the Aegean"
      when "Πανεπιστήμιο Θεσσαλίας"
        organization.name_en = "University of Thessaly"
      when "Πανεπιστήμιο Ιωαννίνων"
        organization.name_en = "University of Ioannina"
      when "Πανεπιστήμιο Κρήτης"
        organization.name_en = "University of Crete"
      when "Πανεπιστήμιο Μακεδονίας"
        organization.name_en = "University of Macedonia"
      when "Πανεπιστήμιο Πατρών"
        organization.name_en = "University of Patras"
      when "Πανεπιστήμιο Πειραιά"
        organization.name_en = "University of Piraeus"
      when "Πανεπιστήμιο Πελλοπονήσου"
        organization.name_en = "University of Peloponnese"
      when "Πάντειον Πανεπιστήμιο"
        organization.name_en = "Panteion University"
      when "Πολυτεχνείο Κρήτης"
        organization.name_en = "Technical University of Crete"
      when "Πυροσβεστική Ακαδημία"
        organization.name_en = nil
      when "Ρυθμιστική Αρχή Ενέργειας"
        organization.name_en = "Regulatory Authority for Energy"
      when "Σχολή Ικάρων"
        organization.name_en = "Hellenic Air Force Academy"
      when "Στρατιωτική Σχολή Ευελπίδων"
        organization.name_en = "Hellenic Army Academy"
      when "Σχολή Ναυτικών Δοκίμων"
        organization.name_en = "Hellenic Naval Academy"
      when "ΤΕΙ Αθηνών"
        organization.name_en = "TEI of Athens"
      when "ΤΕΙ Δυτικής Μακεδονίας"
        organization.name_en = "TEI of Western Macedonia"
      when "ΤΕΙ Ηπείρου"
        organization.name_en = "TEI of Epirus"
      when "ΤΕΙ Ιονίου"
        organization.name_en = "TEI of Ionian Islands"
      when "ΤΕΙ Θεσσαλονίκης"
        organization.name_en = "Alexander TEI of Thessaloniki"
      when "ΤΕΙ Καβάλας"
        organization.name_en = "Eastern Macedonia and Thrace Institute of Technology"
      when "ΤΕΙ Καλαμάτας"
        organization.name_en = "TEI of Peloponnese"
      when "ΤΕΙ Κρήτης"
        organization.name_en = "TEI of Crete"
      when "ΤΕΙ Λαμίας"
        organization.name_en = "TEI of Sterea Ellada"
      when "ΤΕΙ Λάρισας"
        organization.name_en = "TEI of Thessaly"
      when "ΤΕΙ Μεσσολογίου"
        organization.name_en = "TEI of Western Greece"
      when "ΤΕΙ Πάτρας"
        organization.name_en = nil
      when "ΤΕΙ Πειραιά"
        organization.name_en = "TEI of Piraeus"
      when "ΤΕΙ Σερρών"
        organization.name_en = nil
      when "ΤΕΙ Χαλκίδας"
        organization.name_en = nil
      when "Υπουργείο Εθνικής Οικονομίας"
        organization.name_en = "Ministry of Finance"
      when "Υπουργείο Εθνικής Παιδείας & Θρησκευμάτων"
        organization.name_en = nil
      when "Χαροκόπειο Πανεπιστήμιο"
        organization.name_en = "Harokopio University"
      when "Athens Information Technology"
        organization.name_en = "Athens Information Technology"
      end
      organization.save!
    end
  end

  def self.down
    Organization.find_each do |organization|
      case organization.name_el
      when "Ανωτάτη Σχολή Καλών Τεχνών"
        organization.name_en = nil
      when "Ανωτέρα Εκκλησιαστική Σχολή Θεσσαλονίκης"
        organization.name_en = nil
      when "Αριστοτέλειο Πανεπιστήμιο Θεσσαλονίκης"
        organization.name_en = nil
      when "ΑΣΠΑΙΤΕ"
        organization.name_en = nil
      when "Boυλή των Ελλήνων"
        organization.name_en = nil
      when "Γενική Γραμματεία Έρευνας και Τεχνολογίας"
        organization.name_en = nil
      when "Γενική Γραμματεία Πολιτικής Προστασίας"
        organization.name_en = nil
      when "Γεωπονικό Πανεπιστήμιο Αθηνών"
        organization.name_en = nil
      when "Γεωργική και Βιοτεχνική Σχολή Θεσσαλονίκης"
        organization.name_en = nil
      when "Δημοκρίτειο Πανεπιστήμιο Θράκης"
        organization.name_en = nil
      when "Διαχείριση ΕΔΕΤ"
        organization.name_en = nil
      when "Διεθνές κέντρο Δημόσιας Διοίκησης"
        organization.name_en = nil
      when "Δίκτυο Σύζευξις"
        organization.name_en = nil
      when "ΕΚΕΒΕ Α. Φλέμιγκ"
        organization.name_en = nil
      when "Ε.ΚΕ.ΦΕ Δημόκριτος"
        organization.name_en = nil
      when "Εθνικό Αστεροσκοπείο Αθηνών"
        organization.name_en = nil
      when "Εθνικό και Καποδιστριακό Πανεπιστήμιο Αθηνών"
        organization.name_en = nil
      when "Εθνικό Κέντρο Δημόσιας Διοίκησης"
        organization.name_en = nil
      when "Εθνικό Κέντρο Διαβήτη"
        organization.name_en = nil
      when "Εθνικό Κέντρο Θαλάσσιας Ερευνας"
        organization.name_en = nil
      when "Εθνικό Κέντρο Τεκμηρίωσης / EIE"
        organization.name_en = nil
      when "Εθνικό Μετσόβιο Πολυτεχνείο"
        organization.name_en = nil
      when "ΕΙΧΗΜΥΘ"
        organization.name_en = nil
      when "EKETA/Ινστιτούτο Αγροβιοτεχνολογίας"
        organization.name_en = nil
      when "Ελληνικό Ανοιχτό Πανεπιστήμιο"
        organization.name_en = nil
      when "Ελληνικός Οργανισμός Τυποποίησης"
        organization.name_en = nil
      when "Ευρωπαϊκό Κέντρο για την Ανάπτυξη της Επαγγελματικής Κατάρτισης"
        organization.name_en = nil
      when "Ερευνητικό Ακαδημαϊκό Ινστιτούτου Τεχνολογίας Υπολογιστών"
        organization.name_en = nil
      when "ΙΑΣΑ"
        organization.name_en = nil
      when "Ίδρυμα Ευγενίδου"
        organization.name_en = nil
      when "Ίδρυμα Ιατροβιολογικής Έρευνας Ακαδημίας Αθηνών"
        organization.name_en = nil
      when "Ιδρυμα Τεχνολογίας  Ερευνας"
        organization.name_en = nil
      when "Ινστ. Pasteur"
        organization.name_en = nil
      when "Ινστ. Γεωλογικών & Μεταλλευτικών Ερευνών"
        organization.name_en = nil
      when "Ινστ. Επεξεργασίας Λόγου"
        organization.name_en = nil
      when "Ινστιτούτο Θαλάσσιας Βιολογίας"
        organization.name_en = nil
      when "Ινστιτούτο Πολιτιστικής & Εκπαιδευτικής Τεχνολογίας"
        organization.name_en = nil
      when "Ινστιτούτο Τεχνικής Σεισμολογίας & Αντισεισμικών Κατασκευών"
        organization.name_en = nil
      when "Ιόνιο Πανεπιστήμιο"
        organization.name_en = nil
      when "Κέντρο Ανανεώσιμων Πηγών Ενέργειας"
        organization.name_en = nil
      when "Κέντρο Ερευνας για Θέματα Ισότητας"
        organization.name_en = nil
      when "Κέντρο Ελληνικής Γλώσσας"
        organization.name_en = nil
      when "Κέντρο Ερευνών ΝΕΣΤΩΡ"
        organization.name_en = nil
      when "Οικονομικό Πανεπιστήμιο Αθηνών"
        organization.name_en = nil
      when "Οργανισμός Αντισεισμικής Προστασίας"
        organization.name_en = nil
      when "ΟΤΕ – Συγκρότημα Εργαστηρίων Νέων Τεχνολογιών & Υπηρεσιών"
        organization.name_en = nil
      when "Πανελλήνιο Σχολικό Δίκτυο – EDUnet"
        organization.name_en = nil
      when "Πανεπιστήμιο Αιγαίου"
        organization.name_en = nil
      when "Πανεπιστήμιο Θεσσαλίας"
        organization.name_en = nil
      when "Πανεπιστήμιο Ιωαννίνων"
        organization.name_en = nil
      when "Πανεπιστήμιο Κρήτης"
        organization.name_en = nil
      when "Πανεπιστήμιο Μακεδονίας"
        organization.name_en = nil
      when "Πανεπιστήμιο Πατρών"
        organization.name_en = nil
      when "Πανεπιστήμιο Πειραιά"
        organization.name_en = nil
      when "Πανεπιστήμιο Πελλοπονήσου"
        organization.name_en = nil
      when "Πάντειον Πανεπιστήμιο"
        organization.name_en = nil
      when "Πολυτεχνείο Κρήτης"
        organization.name_en = nil
      when "Πυροσβεστική Ακαδημία"
        organization.name_en = nil
      when "Ρυθμιστική Αρχή Ενέργειας"
        organization.name_en = nil
      when "Σχολή Ικάρων"
        organization.name_en = nil
      when "Στρατιωτική Σχολή Ευελπίδων"
        organization.name_en = nil
      when "Σχολή Ναυτικών Δοκίμων"
        organization.name_en = nil
      when "ΤΕΙ Αθηνών"
        organization.name_en = nil
      when "ΤΕΙ Δυτικής Μακεδονίας"
        organization.name_en = nil
      when "ΤΕΙ Ηπείρου"
        organization.name_en = nil
      when "ΤΕΙ Ιονίου"
        organization.name_en = nil
      when "ΤΕΙ Θεσσαλονίκης"
        organization.name_en = nil
      when "ΤΕΙ Καβάλας"
        organization.name_en = nil
      when "ΤΕΙ Καλαμάτας"
        organization.name_en = nil
      when "ΤΕΙ Κρήτης"
        organization.name_en = nil
      when "ΤΕΙ Λαμίας"
        organization.name_en = nil
      when "ΤΕΙ Λάρισας"
        organization.name_en = nil
      when "ΤΕΙ Μεσσολογίου"
        organization.name_en = nil
      when "ΤΕΙ Πάτρας"
        organization.name_en = nil
      when "ΤΕΙ Πειραιά"
        organization.name_en = nil
      when "ΤΕΙ Σερρών"
        organization.name_en = nil
      when "ΤΕΙ Χαλκίδας"
        organization.name_en = nil
      when "Υπουργείο Εθνικής Οικονομίας"
        organization.name_en = nil
      when "Υπουργείο Εθνικής Παιδείας & Θρησκευμάτων"
        organization.name_en = nil
      when "Χαροκόπειο Πανεπιστήμιο"
        organization.name_en = nil
      when "Athens Information Technology"
        organization.name_en = nil
      end
      organization.save!
    end
  end
end
