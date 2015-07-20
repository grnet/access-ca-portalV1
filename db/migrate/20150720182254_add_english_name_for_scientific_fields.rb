class AddEnglishNameForScientificFields < ActiveRecord::Migration
  def self.up
  	add_column :scientific_fields, :description_en, :string
  	rename_column :scientific_fields, :description, :description_el
  	ScientificField.find_each do |sf|
  		case sf.description_el
  		when "Άλλο"
  			sf.description_en = "Other"
		when "Αστροφυσική και σωματιδιακή αστροφυσική"
			sf.description_en = "Astrophysics and particle astrophysics"
		when "Εφαρμογές βιοϊατρικής και βιοπληροφορικής"
			sf.description_en = "Applied biomedicine and bioinformatics"
		when "Υπολογιστική Χημεία"
			sf.description_en = "Computational cshemistry"
		when "Γεωπιστήμες"
			sf.description_en = "Geoscience"
		when "Οικονομία"
			sf.description_en = "Economics"
		when "Σύντηξη"
			sf.description_en = "Fusion"
		when "Γεωφυσική"
			sf.description_en = "Geophysics"
		when "Φυσική υψηλών ενεργειών"
			sf.description_en = "High energy physics"
		when "Μηχανική"
			sf.description_en = "Mechanics"
		when "Επιστήμη υπολογιστών"
			sf.description_en = "Computer science"
		when "Μαθηματικών"
			sf.description_en = "Mathematics"
  		end
  	sf.save!
  	end
  end

  def self.down
  	rename_column :scientific_fields, :description_el, :description
  	remove_column :scientific_fields, :description_en
  end
end
