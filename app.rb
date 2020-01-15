class App
  
  def self.main
    salden = [%w(MONAT ANZAHL_KUNDEN BETRAG UMLAGE SUMME)]
    kx = Pool.create
    monate = (0..35)
    monate.each do |m|
      monatsabrechnung = [%w(MONAT NAME ANZAHL LEISTUNG LEISTUNGSID GESAMTPUNKTZAHL BETRAG UMLAGE SUMME)]
      rechnungen = {}
      monatsdatum = (Pflegedienst::STARTDATUM >> m)
      datum = monatsdatum.strftime("%d.%m.%Y")
      kundenanzahl = 0
      kx.each do |k|
        if k.aktiv?(datum)
          kundenanzahl += 1
          rechnungen.merge!({k.name => k.monatsrechnung(datum)})
        end
      end
      rechnungen.each do |k,v|
        v.each do |posten|
          monatsabrechnung << posten.to_a
        end
      end
      CSV.open("./export/monatsabrechnungen/#{monatsdatum.strftime("%Y-%m")}.csv", "w") do |csv|
        monatsabrechnung.each do |e|
          csv << e
        end
      end

      gesamt = ::Rechnung.monatsabrechnung(rechnungen.values.flatten) 
      salden << [datum[3..-1],kundenanzahl,"#{gesamt.betrag.round(2).co} €", "#{gesamt.pauschale.round(2).co} €","#{gesamt.summe.round(2).co} €"]
    end

    CSV.open("./export/umsatz.csv", "w") do |csv|
      salden.each do |e|
        csv << e
      end
    end

    CSV.open("./export/preisliste.csv", "w") do |csv|
      csv << %w(NUMMER NAME PREIS)
      ::Leistung.Preisliste.each do |e|
        csv << e
      end

    end
  
    CSV.open("./export/kunden.csv", "w") do |csv|
      sorted = []
      kx.each do |k| sorted << k.to_a end
      csv << %w(ID NAME PROFIL ZEITRAUM)
      sorted.sort_by{|k| k[-1]}.each do |e|
        csv << e
      end

    end
  end


end
