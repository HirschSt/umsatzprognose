class App
  
  def self.main(prognose)
    puts "Start von Prognoseverlauf '#{prognose}' ... "
    verlauf = CSV.parse(File.read("./prognosen/#{prognose}.csv"), headers: true)
    startdatum=DateTime.parse(verlauf.to_a[1][0])
    laufzeit=verlauf.to_a.size - 1
    #zielgroesse=verlauf.to_a[verlauf.size][1].to_i
    salden = [%w(MONAT ANZAHL_KUNDEN BETRAG UMLAGE SUMME)]
    kx = Pool.create(verlauf)
    monate = (0..laufzeit - 1)
    monate.each do |m|
      monatsabrechnung = [%w(MONAT NAME ANZAHL LEISTUNG LEISTUNGSID GESAMTPUNKTZAHL BETRAG UMLAGE SUMME)]
      rechnungen = {}
      monatsdatum = (startdatum >> m)
      datum = monatsdatum.strftime("%d.%m.%Y")
      #kundenanzahl = 0
      kx.each do |k|
        if k.aktiv?(datum)
          #kundenanzahl += 1
          rechnungen.merge!({k.name => k.monatsrechnung(startdatum, datum)})
        end
      end
      rechnungen.each do |k,v|
        v.each do |posten|
          monatsabrechnung << posten.to_a
        end
      end
      
      folder = "./prognosen/#{prognose}/monatsabrechnungen/"
      FileUtils.mkdir_p folder
      CSV.open("./prognosen/#{prognose}/monatsabrechnungen/#{monatsdatum.strftime("%Y-%m")}.csv", "w") do |csv|
        monatsabrechnung.each do |e|
          csv << e
        end
      end

      gesamt = ::Rechnung.monatsabrechnung(rechnungen.values.flatten) 
      kundenanzahl = Kunde.aktive(datum, kx)
      salden << [datum[3..-1],kundenanzahl,"#{gesamt.betrag.round(2).co} €", "#{gesamt.pauschale.round(2).co} €","#{gesamt.summe.round(2).co} €"]
    end

    CSV.open("./prognosen/#{prognose}/umsatz.csv", "w") do |csv|
      salden.each do |e|
        csv << e
      end
    end

    CSV.open("./prognosen/#{prognose}/preisliste.csv", "w") do |csv|
      csv << %w(NUMMER NAME PREIS)
      ::Leistung.Preisliste.each do |e|
        csv << e
      end

    end
  
    CSV.open("./prognosen/#{prognose}/kunden.csv", "w") do |csv|
      sorted = []
      kx.each do |k| sorted << k.to_a end
      csv << %w(ID NAME PROFIL ZEITRAUM)
      sorted.sort_by{|k| k[-1]}.each do |e|
        csv << e
      end

    end
  end


end
