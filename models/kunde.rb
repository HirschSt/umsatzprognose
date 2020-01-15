class Kunde

  attr_accessor :id, :leistungen, :name, :profil, :profilid, :zeitraum
  
  def initialize(id, name, profil, von, bis)
    @id = id
    @zeitraum=von..bis
    profile = YAML.load_file('./config/profile.yml')
    @profilid = profil
    @profil = profile[profil]
    @leistungen = @profil["leistungen"]
    @name = name
  end

  def monat(wochentage, start=DateTime.parse("2020-08-01"))
    zr = (start .. ((start >> 1) - 1))   
    res = [0,0,0,0,0,0,0]
    tage = 0
    while (zr.include?(zr.first + tage))
      if wochentage.include?((zr.first + tage).wday)
        res[(zr.first + tage).wday] += 1
      end
      tage += 1
    end    
    return res.sum
  end

  def monatsrechnung(start="1.8.2020")
    start=DateTime.parse(start)
    leistungskatalog = Leistung.Gesamt
    punktwert = Leistung.PUNKTWERT(start)
    res = []
    if (start == zeitraum.first) && erstgespraech?
      erstgespraech = leistungskatalog[12]
      betrag = punktwert * (erstgespraech["punktzahl"] * 1)
      res << Posten.new(start, betrag, 12, erstgespraech["name"], 1, self.name, erstgespraech["punktzahl"])
    end
    @leistungen.each do |l|
      posten = leistungskatalog[l["id"]]
      gesamtpunktzahl = 0
      if l["schema"]
        anzahl = monat(l["schema"], start)
      elsif l["anzahl"]
        anzahl = l["anzahl"]
      end
      begin
        if posten["punktzahl"]
          betrag = punktwert * (posten["punktzahl"] * anzahl)
          gesamtpunktzahl = posten["punktzahl"] * anzahl
        elsif posten["preis"]
          betrag = posten["preis"] * anzahl
        else
          puts l
        end
      rescue
        puts l
      end
      res << Posten.new(start, betrag, l["id"], posten["name"], anzahl, self.name, gesamtpunktzahl )
    end
    return res
  end

  def erstgespraech?
    leistungen.each do |leistung|
      return true if leistung["id"] < 20
    end
    return false
  end

  def aktiv?(datum)
    datum = DateTime.parse(datum)
    zeitraum.cover?(datum)
  end

  def zaehle_aktive(list)
    
  end

  def anzahl(wochentage)
    res = [0,0,0,0,0,0,0]
    tage = 0
    while (@zeitraum.include?(@zeitraum.first + tage))
      if wochentage.include?((@zeitraum.first + tage).wday)
        res[(@zeitraum.first + tage).wday] += 1
      end
      tage += 1
    end
    return res
  end

  def to_s
    "#{id}, #{name}, #{profil}, #{zeitraum}"
  end

  def to_a
    [id, name, profilid, "#{zeitraum.first.strftime("%Y/%m")}-#{zeitraum.last.strftime("%Y/%m")}"]  
  end


end
